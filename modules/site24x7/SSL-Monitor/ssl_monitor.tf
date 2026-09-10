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

resource "site24x7_ssl_monitor" "ssl_monitor" {
  display_name              = var.display_name
  domain_name               = var.domain_name
  port                      = var.port
  protocol                  = var.protocol
  expire_days               = var.expire_days
  http_protocol_version     = var.http_protocol_version
  ignore_domain_mismatch    = var.ignore_domain_mismatch
  ignore_trust              = var.ignore_trust
  location_profile_id       = var.location_profile_id
  location_profile_name     = var.location_profile_name
  notification_profile_id   = var.notification_profile_id
  notification_profile_name = var.notification_profile_name
  threshold_profile_id      = var.threshold_profile_id
  monitor_groups            = var.monitor_groups
  dependency_resource_ids   = var.dependency_resource_ids
  user_group_ids            = var.user_group_ids
  user_group_names          = var.user_group_names
  tag_ids                   = var.tag_ids
  tag_names                 = var.tag_names
  third_party_service_ids   = var.third_party_service_ids
}
