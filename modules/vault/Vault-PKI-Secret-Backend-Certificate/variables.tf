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

variable "pki_backend_path" {
  description = "The path to which the PKI backend would be mounted"
  type        = string
}

variable "role_name" {
  description = "Name of the role to create the certificate against"
  type        = string
}

variable "common_name" {
  description = "CN of certificate to create"
  type        = string
}

variable "alt_names" {
  description = "List of alternative names"
  type        = list(string)
  default     = []
}

variable "other_sans" {
  description = "List of other SANs"
  type        = list(string)
  default     = []
}

variable "ttl" {
  description = "Certificate's time to live"
  type        = string
  default     = "8760h"
}

variable "format" {
  description = "Certificate's format"
  type        = string
  default     = "pem"
}

variable "private_key_format" {
  description = "Private key's format"
  type        = string
  default     = "pkcs8"
}

variable "min_seconds_remaining" {
  description = "Generate a new certificate when the expiration is within this number of seconds"
  type        = number
  default     = 2592000 # 30 days
}

variable "auto_renew" {
  description = "The certificate will be renewed if the expiration is within min_seconds_remaining"
  type        = bool
  default     = true
}
