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
  description = "Name of the location profile. Note: the site24x7 provider (through v2.0.8) does not refresh this attribute into state on read, so manage it exclusively through Terraform; out-of-band renames will not be detected as drift."
  type        = string
}

variable "primary_location" {
  description = "Primary polling location ID (provider-native numeric location code, as a string)."
  type        = string
}

variable "secondary_locations" {
  description = "Secondary polling location IDs (provider-native numeric location codes, as strings)."
  type        = list(string)
}

variable "restrict_alternate_location_polling" {
  description = "Whether to restrict polling to only the configured locations."
  type        = bool
  default     = null
}

variable "outer_regions_location_consent" {
  description = "Consent to poll from outer-region locations."
  type        = bool
  default     = null
}
