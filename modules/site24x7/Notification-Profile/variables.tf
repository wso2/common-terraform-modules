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

variable "profile_name" {
  description = "Name of the notification profile."
  type        = string
}

variable "rca_needed" {
  description = "Whether root-cause analysis is required."
  type        = bool
  default     = null
}

variable "notify_after_executing_actions" {
  description = "Whether to notify only after configured actions have run."
  type        = bool
  default     = null
}

variable "template_id" {
  description = "Notification template ID."
  type        = string
  default     = null
}

variable "suppress_automation" {
  description = "Whether to suppress automation on notifications."
  type        = bool
  default     = null
}

variable "escalation_automations" {
  description = "Escalation automation IDs."
  type        = list(string)
  default     = null
}

variable "alert_configuration" {
  description = "Alert configuration blocks. status/notification_medium are provider-native numeric codes; outside_business_hours is a provider-native string (\"0\" within, \"1\" outside business hours)."
  type = list(object({
    status                 = optional(number)
    business_hours_id      = optional(string)
    notification_medium    = list(number)
    outside_business_hours = optional(string)
  }))
  nullable = false
  default  = []
}

variable "notification_delay_configuration" {
  description = "Notification delay configuration blocks (provider-native numeric codes); outside_business_hours is a provider-native string (\"0\" within, \"1\" outside business hours)."
  type = list(object({
    status                 = optional(number)
    business_hours_id      = optional(string)
    notification_delay     = optional(number)
    outside_business_hours = optional(string)
  }))
  nullable = false
  default  = []
}

variable "persistent_alert_configuration" {
  description = "Persistent alert configuration blocks (provider-native numeric codes)."
  type = list(object({
    notify_every         = number
    notification_medium  = list(number)
    third_party_services = optional(list(string))
  }))
  nullable = false
  default  = []
}

variable "escalation_levels" {
  description = "Escalation level blocks (provider-native numeric codes)."
  type = list(object({
    user_group_id        = string
    escalation_wait_time = number
    notification_medium  = list(number)
    third_party_services = optional(list(string))
  }))
  nullable = false
  default  = []
}
