locals {
  # One entry per resource. Each becomes a warning + critical rule.
  # Every rule is multi-dimensional: one alert instance per VM
  # (per VM + mount point for disk), so new VMs are covered automatically.
  checks = {
    memory = {
      title       = "VM usable memory low"
      operator    = "lt"
      thresholds  = var.memory_usable_pct
      pending     = "5m"
      expr        = <<-EOT
        100 *
        max by (namespace, name) (kubevirt_vmi_memory_usable_bytes)
        /
        max by (namespace, name) (kubevirt_vmi_memory_available_bytes)
      EOT
      summary     = "Low usable memory on VM {{ $labels.name }}"
      description = "Only {{ printf \"%.1f\" $values.A.Value }}% of memory is usable on {{ $labels.namespace }}/{{ $labels.name }} (threshold: __THRESHOLD__%)"
    }

    disk = {
      title       = "VM disk space low"
      operator    = "lt"
      thresholds  = var.disk_free_pct
      pending     = "10m"
      expr        = <<-EOT
        100 * (1 -
          max by (namespace, name, mount_point) (kubevirt_vmi_filesystem_used_bytes{file_system_type=~"${var.disk_fs_types}", mount_point="${var.disk_mount_point}"})
          /
          max by (namespace, name, mount_point) (kubevirt_vmi_filesystem_capacity_bytes{file_system_type=~"${var.disk_fs_types}", mount_point="${var.disk_mount_point}"})
        )
      EOT
      summary     = "Low disk space on VM {{ $labels.name }} ({{ $labels.mount_point }})"
      description = "Only {{ printf \"%.1f\" $values.A.Value }}% free on {{ $labels.mount_point }} of {{ $labels.namespace }}/{{ $labels.name }} (threshold: __THRESHOLD__%)"
    }

    cpu = {
      title       = "VM CPU usage high"
      operator    = "gt"
      thresholds  = var.cpu_used_pct
      pending     = "15m"
      expr        = <<-EOT
        100 * avg by (namespace, name) (
          rate(kubevirt_vmi_vcpu_seconds_total{state=~"(?i)running"}[5m])
        )
      EOT
      summary     = "High CPU usage on VM {{ $labels.name }}"
      description = "CPU usage is {{ printf \"%.1f\" $values.A.Value }}% on {{ $labels.namespace }}/{{ $labels.name }} (threshold: __THRESHOLD__%)"
    }
  }

  # Expand to one rule per check x severity.
  # Critical: plain lt/gt. Warning: band between warning and critical,
  # so a VM never has a warning AND a critical incident open at once.
  rules = flatten([
    for ck, c in local.checks : [
      for sev, thr in c.thresholds : {
        title   = "${c.title} (${sev})"
        expr    = c.expr
        pending = c.pending
        evaluator = sev == "critical" ? {
          type   = c.operator
          params = [thr]
          } : {
          type   = "within_range"
          params = [min(c.thresholds["warning"], c.thresholds["critical"]), max(c.thresholds["warning"], c.thresholds["critical"])]
        }
        labels      = merge(var.common_labels, { severity = sev, resource = ck })
        summary     = c.summary
        description = replace(c.description, "__THRESHOLD__", tostring(thr))
      }
    ]
  ])
}

# Look up the Prometheus data source the rules will query
data "grafana_data_source" "prometheus" {
  name = var.prometheus_datasource_name
}

resource "grafana_folder" "vm_alerts" {
  title = var.folder_title
}

resource "grafana_rule_group" "vm_resources" {
  name             = var.rule_group_name
  folder_uid       = grafana_folder.vm_alerts.uid
  interval_seconds = 60

  dynamic "rule" {
    for_each = local.rules
    content {
      name           = rule.value.title
      condition      = "C"
      for            = rule.value.pending
      no_data_state  = "OK"       # stopped/deleted VMs don't alert
      exec_err_state = "KeepLast" # use "Error" on older Grafana/provider versions
      labels         = rule.value.labels
      annotations = {
        summary     = rule.value.summary
        description = rule.value.description
      }

      # A: the PromQL query (instant)
      data {
        ref_id         = "A"
        datasource_uid = data.grafana_data_source.prometheus.uid
        relative_time_range {
          from = 600
          to   = 0
        }
        model = jsonencode({
          refId         = "A"
          expr          = rule.value.expr
          instant       = true
          range         = false
          intervalMs    = 1000
          maxDataPoints = 43200
        })
      }

      # C: threshold on A
      data {
        ref_id         = "C"
        datasource_uid = "__expr__"
        relative_time_range {
          from = 0
          to   = 0
        }
        model = jsonencode({
          refId      = "C"
          type       = "threshold"
          expression = "A"
          conditions = [{ evaluator = rule.value.evaluator }]
        })
      }

      # Route straight to ServiceNow (simplified routing).
      # Remove this block if a notification policy does the routing.
      notification_settings {
        contact_point = grafana_contact_point.servicenow.name
        group_by      = ["..."]
      }
    }
  }
}
