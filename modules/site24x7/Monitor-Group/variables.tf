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

variable "display_name" {
  description = "Display name of the monitor group."
  type        = string
}

variable "description" {
  description = "Description of the monitor group."
  type        = string
  default     = null
}

variable "health_threshold_count" {
  description = "Number of monitors that must be down before the group is considered down."
  type        = number
  default     = null
}

variable "dependency_resource_ids" {
  description = "Monitor IDs this group depends on."
  type        = list(string)
  default     = null
}

variable "suppress_alert" {
  description = "Whether to suppress alerts based on the dependency configuration."
  type        = bool
  default     = null
}

variable "healthcheck_profile_id" {
  description = "Health-check profile ID for the group."
  type        = string
  default     = null
}

variable "notification_profile_id" {
  description = "Notification profile ID for the group (provider-native ID)."
  type        = string
  default     = null
}

variable "user_group_ids" {
  description = "User group IDs to notify for the group."
  type        = list(string)
  default     = null
}

variable "tag_ids" {
  description = "Tag IDs to attach to the group."
  type        = list(string)
  default     = null
}

variable "third_party_service_ids" {
  description = "Third-party service IDs associated with the group."
  type        = list(string)
  default     = null
}

variable "enable_incident_management" {
  description = "Whether incident management is enabled for the group."
  type        = bool
  default     = null
}
