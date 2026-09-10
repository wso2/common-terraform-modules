# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "site24x7_notification_profile" "notification_profile" {
  profile_name                   = var.profile_name
  rca_needed                     = var.rca_needed
  notify_after_executing_actions = var.notify_after_executing_actions
  template_id                    = var.template_id
  suppress_automation            = var.suppress_automation
  escalation_automations         = var.escalation_automations

  dynamic "alert_configuration" {
    for_each = var.alert_configuration
    content {
      status                 = try(alert_configuration.value.status, null)
      business_hours_id      = try(alert_configuration.value.business_hours_id, null)
      notification_medium    = alert_configuration.value.notification_medium
      outside_business_hours = try(alert_configuration.value.outside_business_hours, null)
    }
  }

  dynamic "notification_delay_configuration" {
    for_each = var.notification_delay_configuration
    content {
      status                 = try(notification_delay_configuration.value.status, null)
      business_hours_id      = try(notification_delay_configuration.value.business_hours_id, null)
      notification_delay     = try(notification_delay_configuration.value.notification_delay, null)
      outside_business_hours = try(notification_delay_configuration.value.outside_business_hours, null)
    }
  }

  dynamic "persistent_alert_configuration" {
    for_each = var.persistent_alert_configuration
    content {
      notify_every         = persistent_alert_configuration.value.notify_every
      notification_medium  = persistent_alert_configuration.value.notification_medium
      third_party_services = try(persistent_alert_configuration.value.third_party_services, null)
    }
  }

  dynamic "escalation_levels" {
    for_each = var.escalation_levels
    content {
      user_group_id        = escalation_levels.value.user_group_id
      escalation_wait_time = escalation_levels.value.escalation_wait_time
      notification_medium  = escalation_levels.value.notification_medium
      third_party_services = try(escalation_levels.value.third_party_services, null)
    }
  }
}
