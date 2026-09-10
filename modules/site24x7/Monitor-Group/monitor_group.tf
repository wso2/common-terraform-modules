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

resource "site24x7_monitor_group" "monitor_group" {
  lifecycle {
    precondition {
      condition     = !coalesce(var.suppress_alert, false) || length(coalesce(var.dependency_resource_ids, [])) > 0
      error_message = "dependency_resource_ids must contain at least one ID when suppress_alert is true."
    }
  }

  display_name               = var.display_name
  description                = var.description
  health_threshold_count     = var.health_threshold_count
  dependency_resource_ids    = var.dependency_resource_ids
  suppress_alert             = var.suppress_alert
  healthcheck_profile_id     = var.healthcheck_profile_id
  notification_profile_id    = var.notification_profile_id
  user_group_ids             = var.user_group_ids
  tag_ids                    = var.tag_ids
  third_party_service_ids    = var.third_party_service_ids
  enable_incident_management = var.enable_incident_management
}
