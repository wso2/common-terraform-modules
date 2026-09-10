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
  description = "Name of the threshold profile."
  type        = string
}

variable "type" {
  description = "Monitor type this threshold profile applies to (e.g. \"SSL_CERT\", \"URL\")."
  type        = string
}

variable "profile_type" {
  description = "Threshold profile type (1 = static, 2 = AI-based)."
  type        = number
  default     = 1
}

variable "down_location_threshold" {
  description = "Number of locations that must report down before the monitor is down."
  type        = number
  default     = null
}

variable "website_content_modified" {
  description = "Whether to alert when website content is modified."
  type        = bool
  default     = null
}

variable "read_time_out" {
  description = "Read timeout threshold object (provider-native map, e.g. { severity, value })."
  type        = any
  default     = null
}

variable "primary_response_time_trouble_threshold" {
  description = "Primary response-time trouble threshold object (provider-native; codes already resolved)."
  type        = any
  default     = null
}

variable "primary_response_time_critical_threshold" {
  description = "Primary response-time critical threshold object (provider-native)."
  type        = any
  default     = null
}

variable "secondary_response_time_trouble_threshold" {
  description = "Secondary response-time trouble threshold object (provider-native)."
  type        = any
  default     = null
}

variable "secondary_response_time_critical_threshold" {
  description = "Secondary response-time critical threshold object (provider-native)."
  type        = any
  default     = null
}

variable "website_content_changes" {
  description = "List of website-content-change thresholds. severity/value/comparison_operator are provider-native numeric codes."
  type = list(object({
    severity            = number
    value               = number
    comparison_operator = optional(number)
  }))
  nullable = false
  default  = []
}

variable "ssl_cert_days_until_expiry_trouble_threshold" {
  description = "SSL-days-until-expiry trouble threshold object (provider-native map, e.g. { severity, value })."
  type        = any
  default     = null
}

variable "ssl_cert_days_until_expiry_critical_threshold" {
  description = "SSL-days-until-expiry critical threshold object (provider-native map, e.g. { severity, value }). The site24x7 provider (v2.0.5) only accepts severity = 2 for this field; the module normalizes severity to 2 before passing it to the provider."
  type        = any
  default     = null
}

variable "ssl_cert_fingerprint_modified" {
  description = "Whether to alert when the SSL certificate fingerprint changes."
  type        = bool
  default     = null
}
