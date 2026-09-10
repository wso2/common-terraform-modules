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
  description = "Display name of the SSL monitor."
  type        = string
}

variable "domain_name" {
  description = "Domain name whose certificate is monitored."
  type        = string
}

variable "port" {
  description = "Port to check the certificate on."
  type        = number
  default     = 443
}

variable "protocol" {
  description = "Protocol to use (e.g. HTTPS, SMTPS)."
  type        = string
  default     = "HTTPS"
}

variable "expire_days" {
  description = "Days before expiry at which to start alerting."
  type        = number
  default     = 30
}

variable "http_protocol_version" {
  description = "HTTP protocol version (e.g. H1.1, H2)."
  type        = string
  default     = "H1.1"
}

variable "ignore_domain_mismatch" {
  description = "Whether to ignore certificate domain mismatches."
  type        = bool
  default     = false
}

variable "ignore_trust" {
  description = "Whether to ignore certificate trust errors."
  type        = bool
  default     = false
}

variable "location_profile_id" {
  description = "Location profile ID (provider-native). Set this or location_profile_name."
  type        = string
  default     = null
}

variable "location_profile_name" {
  description = "Location profile name. Set this or location_profile_id."
  type        = string
  default     = null
}

variable "notification_profile_id" {
  description = "Notification profile ID (provider-native). Set this or notification_profile_name."
  type        = string
  default     = null
}

variable "notification_profile_name" {
  description = "Notification profile name. Set this or notification_profile_id."
  type        = string
  default     = null
}

variable "threshold_profile_id" {
  description = "Threshold profile ID (provider-native)."
  type        = string
  default     = null
}

variable "monitor_groups" {
  description = "Monitor group IDs this monitor belongs to."
  type        = list(string)
  default     = null
}

variable "dependency_resource_ids" {
  description = "Resource IDs this monitor depends on."
  type        = list(string)
  default     = null
}

variable "user_group_ids" {
  description = "User group IDs to notify."
  type        = list(string)
  default     = null
}

variable "user_group_names" {
  description = "User group names to notify."
  type        = list(string)
  default     = null
}

variable "tag_ids" {
  description = "Tag IDs to attach."
  type        = list(string)
  default     = null
}

variable "tag_names" {
  description = "Tag names to attach."
  type        = list(string)
  default     = null
}

variable "third_party_service_ids" {
  description = "Third-party service IDs to notify."
  type        = list(string)
  default     = null
}
