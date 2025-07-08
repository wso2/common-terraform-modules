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

variable "name" {
  description = "A unique name to identify this role within the backend"
  type        = string
}

variable "issuer_ref" {
  description = "The default issuer of this request"
  type        = string
  default     = "default"
}

variable "ttl" {
  description = "The default TTL of any issued certificate against this role"
  type        = number
  default     = 31536000 # 1 year
}

variable "max_ttl" {
  description = "The maximum allowed TTL for an issued certificate against this role"
  type        = number
  default     = 63072000 # 2 years
}

variable "allow_localhost" {
  description = "Flag to allow certificates for localhost"
  type        = bool
  default     = false
}

variable "allow_bare_domains" {
  description = "Flag to allow certificates matching the actual domain"
  type        = bool
  default     = false
}

variable "allow_subdomains" {
  description = "Flag to allow certificates matching subdomains"
  type        = bool
  default     = true
}

variable "allow_glob_domains" {
  description = "Flag to allow names containing glob patterns"
  type        = bool
  default     = false
}

variable "allow_any_name" {
  description = "Flag to allow any name"
  type        = bool
  default     = false
}

variable "allow_ip_sans" {
  description = "Flag to allow IP SANs"
  type        = bool
  default     = false
}

variable "allow_wildcard_certificates" {
  description = "Flag to allow wildcard certificates"
  type        = bool
  default     = false
}

variable "allowed_domains" {
  description = "List of allowed domains for certificates"
  type        = list(string)
  default     = []
}

variable "allowed_other_sans" {
  description = "List of allowed custom SANs for certificates"
  type        = list(string)
  default     = []
}

variable "server_flag" {
  description = "Flag to specify a certificate is for server use"
  type        = bool
  default     = false
}

variable "client_flag" {
  description = "Flag to specify a certificate is for client use"
  type        = bool
  default     = true
}

variable "key_type" {
  description = "The generated key type"
  type        = string
  default     = "rsa"
  validation {
    condition     = contains(["rsa", "ec", "ed25519", "any"], var.key_type)
    error_message = "Valid values for key_type are: rsa, ec, ed25519, any."
  }
}

variable "key_bits" {
  description = "The number of bits of generated keys"
  type        = number
  default     = 2048
}

variable "key_usage" {
  description = "Specify the allowed key usage constraint on issued certificates"
  type        = list(string)
  default     = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}

variable "default_org_units" {
  description = "Specifies which OU(s) to embed in the certificate’s Subject Distinguished Name (DN)"
  type        = list(string)
  default     = []
}

variable "default_organizations" {
  description = "Specifies the organization(s) embedded in the certificate’s Subject Distinguished Name (DN)"
  type        = list(string)
  default     = []
}

variable "default_country" {
  description = "Specifies the country embedded in the certificate’s Subject Distinguished Name (DN)"
  type        = list(string)
  default     = []
}

variable "default_locality" {
  description = "Specifies the locality embedded in the certificate’s Subject Distinguished Name (DN)"
  type        = list(string)
  default     = []
}

variable "default_province" {
  description = "Specifies the province embedded in the certificate’s Subject Distinguished Name (DN)"
  type        = list(string)
  default     = []
}

variable "no_store" {
  description = "Flag to not store certificates in the storage backend"
  type        = bool
  default     = false
}
