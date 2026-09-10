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

resource "site24x7_threshold_profile" "threshold_profile" {
  profile_name            = var.profile_name
  type                    = var.type
  profile_type            = var.profile_type
  down_location_threshold = var.down_location_threshold

  website_content_modified = var.website_content_modified
  read_time_out            = var.read_time_out

  primary_response_time_trouble_threshold    = var.primary_response_time_trouble_threshold
  primary_response_time_critical_threshold   = var.primary_response_time_critical_threshold
  secondary_response_time_trouble_threshold  = var.secondary_response_time_trouble_threshold
  secondary_response_time_critical_threshold = var.secondary_response_time_critical_threshold

  dynamic "website_content_changes" {
    for_each = var.website_content_changes
    content {
      severity            = website_content_changes.value.severity
      value               = website_content_changes.value.value
      comparison_operator = try(website_content_changes.value.comparison_operator, null)
    }
  }

  ssl_cert_days_until_expiry_trouble_threshold  = var.ssl_cert_days_until_expiry_trouble_threshold
  ssl_cert_days_until_expiry_critical_threshold = var.ssl_cert_days_until_expiry_critical_threshold == null ? null : merge(var.ssl_cert_days_until_expiry_critical_threshold, { severity = 2 })
  ssl_cert_fingerprint_modified                 = var.ssl_cert_fingerprint_modified
}
