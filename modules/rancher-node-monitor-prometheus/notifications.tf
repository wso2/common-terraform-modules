resource "grafana_contact_point" "servicenow" {
  name = "servicenow-webhook"

  webhook {
    url                     = var.servicenow_url
    http_method             = "POST"
    basic_auth_user         = var.servicenow_username
    basic_auth_password     = var.servicenow_password
    max_alerts              = 0
    disable_resolve_message = false # = send_resolved: true
  }
}

# WARNING: this resource replaces the entire policy tree of the org.
# Keep it disabled if policies are managed in the UI; route via the
# rule-level notification_settings in alerts.tf instead.
resource "grafana_notification_policy" "root" {
  count = var.manage_notification_policy ? 1 : 0

  contact_point = var.default_contact_point
  group_by      = ["grafana_folder", "alertname"]

  policy {
    contact_point   = grafana_contact_point.servicenow.name
    group_by        = ["..."] # one notification per alert instance
    repeat_interval = "4h"

    matcher {
      label = "service"
      match = "="
      value = var.common_labels["service"]
    }
  }
}
