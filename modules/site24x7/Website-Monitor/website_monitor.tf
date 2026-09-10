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

resource "site24x7_website_monitor" "website_monitor" {
  lifecycle {
    precondition {
      condition     = (var.location_profile_id != null) != (var.location_profile_name != null)
      error_message = "Set exactly one of location_profile_id or location_profile_name. Leaving both unset makes the provider pick the first available profile based on account ordering."
    }

    precondition {
      condition     = (var.notification_profile_id != null) != (var.notification_profile_name != null)
      error_message = "Set exactly one of notification_profile_id or notification_profile_name. Leaving both unset makes the provider pick the first available profile based on account ordering."
    }

    precondition {
      condition     = var.credential_profile_id == null || (var.auth_user == null && var.auth_pass == null)
      error_message = "Use either credential_profile_id or auth_user/auth_pass for authentication, not both."
    }

    precondition {
      condition     = !(var.user_group_ids != null && var.user_group_names != null)
      error_message = "Set at most one of user_group_ids or user_group_names, not both."
    }

    precondition {
      condition     = !(var.tag_ids != null && var.tag_names != null)
      error_message = "Set at most one of tag_ids or tag_names, not both."
    }
  }

  display_name                = var.display_name
  website                     = var.website
  check_frequency             = var.check_frequency
  timeout                     = var.timeout
  auth_user                   = var.auth_user
  auth_pass                   = var.auth_pass
  credential_profile_id       = var.credential_profile_id
  matching_keyword_value      = var.matching_keyword_value
  matching_keyword_severity   = var.matching_keyword_severity
  unmatching_keyword_value    = var.unmatching_keyword_value
  unmatching_keyword_severity = var.unmatching_keyword_severity
  match_regex_value           = var.match_regex_value
  match_regex_severity        = var.match_regex_severity
  match_case                  = var.match_case
  user_agent                  = var.user_agent
  location_profile_id         = var.location_profile_id
  location_profile_name       = var.location_profile_name
  notification_profile_id     = var.notification_profile_id
  notification_profile_name   = var.notification_profile_name
  threshold_profile_id        = var.threshold_profile_id
  monitor_groups              = var.monitor_groups
  dependency_resource_ids     = var.dependency_resource_ids
  user_group_ids              = var.user_group_ids
  user_group_names            = var.user_group_names
  tag_ids                     = var.tag_ids
  tag_names                   = var.tag_names
  third_party_service_ids     = var.third_party_service_ids
  actions                     = var.actions
  use_name_server             = var.use_name_server
  up_status_codes             = var.up_status_codes
  follow_http_redirection     = var.follow_http_redirection
  ignore_cert_err             = var.ignore_cert_err
  http_method                 = var.http_method
  http_protocol               = var.http_protocol
  request_content_type        = var.request_content_type
  request_body                = var.request_body
  request_headers             = var.request_headers
  response_headers_severity   = var.response_headers_severity
  response_headers            = var.response_headers
}
