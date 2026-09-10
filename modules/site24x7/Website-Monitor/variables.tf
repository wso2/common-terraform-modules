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
  description = "Display name of the website monitor."
  type        = string
}

variable "website" {
  description = "URL to monitor."
  type        = string
}

variable "check_frequency" {
  description = "Check frequency in minutes."
  type        = number
  default     = 1
}

variable "timeout" {
  description = "Request timeout in seconds."
  type        = number
  default     = 10
}

variable "auth_user" {
  description = "Basic-auth username."
  type        = string
  default     = null
}

variable "auth_pass" {
  description = "Basic-auth password."
  type        = string
  default     = null
  sensitive   = true
}

variable "credential_profile_id" {
  description = "Credential profile ID."
  type        = string
  default     = null
}

variable "matching_keyword_value" {
  description = "Keyword whose presence marks the monitor up."
  type        = string
  default     = null
}

variable "matching_keyword_severity" {
  description = "Severity when the matching keyword is absent (provider-native numeric code)."
  type        = number
  default     = null
}

variable "unmatching_keyword_value" {
  description = "Keyword whose absence marks the monitor up."
  type        = string
  default     = null
}

variable "unmatching_keyword_severity" {
  description = "Severity when the unmatching keyword is present (provider-native numeric code)."
  type        = number
  default     = null
}

variable "match_regex_value" {
  description = "Regex the response must match."
  type        = string
  default     = null
}

variable "match_regex_severity" {
  description = "Severity when the regex does not match (provider-native numeric code)."
  type        = number
  default     = null
}

variable "match_case" {
  description = "Whether keyword/regex matching is case-sensitive."
  type        = bool
  default     = false
}

variable "user_agent" {
  description = "User agent to send with requests."
  type        = string
  default     = null
}

variable "location_profile_id" {
  description = "Location profile ID (provider-native). Set exactly one of location_profile_id or location_profile_name."
  type        = string
  default     = null
}

variable "location_profile_name" {
  description = "Location profile name. Set exactly one of location_profile_id or location_profile_name."
  type        = string
  default     = null
}

variable "notification_profile_id" {
  description = "Notification profile ID (provider-native). Set exactly one of notification_profile_id or notification_profile_name."
  type        = string
  default     = null
}

variable "notification_profile_name" {
  description = "Notification profile name. Set exactly one of notification_profile_id or notification_profile_name."
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

variable "actions" {
  description = "Monitor action mappings (provider-native)."
  type        = any
  default     = null
}

variable "use_name_server" {
  description = "Whether to resolve using the configured name server."
  type        = bool
  default     = null
}

variable "up_status_codes" {
  description = "Comma-separated HTTP status codes that count as up."
  type        = string
  default     = null
}

variable "follow_http_redirection" {
  description = "Whether to follow HTTP redirects."
  type        = bool
  default     = null
}

variable "ignore_cert_err" {
  description = "Whether to ignore certificate errors."
  type        = bool
  default     = null
}

variable "http_method" {
  description = "HTTP method to use (G, P, etc.)."
  type        = string
  default     = null
}

variable "http_protocol" {
  description = "HTTP protocol version (e.g. H1.1, H2)."
  type        = string
  default     = "H1.1"
}

variable "request_content_type" {
  description = "Content type of the request body."
  type        = string
  default     = null
}

variable "request_body" {
  description = "Request body to send."
  type        = string
  default     = null
  sensitive   = true
}

variable "request_headers" {
  description = "Request headers to send (provider-native)."
  type        = any
  default     = null
  sensitive   = true
}

variable "response_headers_severity" {
  description = "Severity when response headers do not match (provider-native numeric code)."
  type        = number
  default     = null
}

variable "response_headers" {
  description = "Response headers to check (provider-native)."
  type        = any
  default     = null
}
