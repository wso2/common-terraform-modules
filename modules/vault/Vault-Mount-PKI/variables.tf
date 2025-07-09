# ---------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com).
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
# ---------------------------------------------------------------------------------

variable "path" {
  description = "The path to which the PKI backend would be mounted"
  type        = string
}

variable "default_lease_ttl_seconds" {
  description = "The default TTL of an issued certificate of this PKI backend"
  type        = number
  default     = 31536000 # 1 year
}

variable "max_lease_ttl_seconds" {
  description = "The maximum allowed TTL for an issued certificate of this PKI backend"
  type        = number
  default     = 63072000 # 2 years
}

variable "certificate_issuer_pem_bundle" {
  description = "The default issuer asymmetric key pair PEM bundle of this PKI backend"
  type        = string
}
