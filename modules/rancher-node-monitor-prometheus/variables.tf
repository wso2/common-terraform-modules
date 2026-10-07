# ---------- Grafana connection ----------
variable "grafana_url" {
  type        = string
  description = "Grafana base URL, e.g. https://grafana.bc-stg.example.com"
}

variable "grafana_auth" {
  type        = string
  sensitive   = true
  description = "Grafana service account token (Editor or Admin)"
}

variable "prometheus_datasource_name" {
  type    = string
  default = "Prometheus"
}

variable "folder_title" {
  type    = string
  default = "Harvester VM Alerts"
}

variable "rule_group_name" {
  type    = string
  default = "kubevirt-vm-resources"
}

# ---------- ServiceNow webhook ----------
variable "servicenow_url" {
  type        = string
  description = " sample URL like https://sample-dev.service-now.com/api/wso2/v1/sre_alert_api/prometheus"
}

variable "servicenow_username" {
  type      = string
  sensitive = true
}

variable "servicenow_password" {
  type      = string
  sensitive = true
}

# Set true only if Terraform should own the WHOLE notification policy tree
variable "manage_notification_policy" {
  type    = bool
  default = false
}

variable "default_contact_point" {
  type        = string
  default     = "grafana-default-email"
  description = "Root policy receiver, used only when manage_notification_policy = true"
}

# ---------- Labels sent to ServiceNow ----------
variable "common_labels" {
  type = map(string)
  default = {
    component   = "system"
    service     = "client-customer-alert-integration"
    environment = "production"
    category    = "service_interruption"
  }
}

# ---------- Thresholds (percent) ----------
variable "memory_usable_pct" {
  type        = map(number)
  description = "Alert when usable memory % drops BELOW these"
  default     = { warning = 20, critical = 10 }
}

variable "disk_free_pct" {
  type        = map(number)
  description = "Alert when free disk % drops BELOW these"
  default     = { warning = 20, critical = 10 }
}

variable "cpu_used_pct" {
  type        = map(number)
  description = "Alert when CPU usage % goes ABOVE these"
  default     = { warning = 80, critical = 90 }
}

variable "disk_fs_types" {
  type        = string
  description = "Regex of guest filesystem types to monitor (excludes tmpfs/overlay noise)"
  default     = "ext4|xfs|btrfs"
}

variable "disk_mount_point" {
  type        = string
  description = "Disk mount point of filesystems to monitor"
  default     = "/"
}
