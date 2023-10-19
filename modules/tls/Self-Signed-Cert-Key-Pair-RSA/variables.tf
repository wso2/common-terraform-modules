# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "private_key_rsa_bits" {
  description = "The size of the generated RSA private key in bits. Defaults to 2048"
  type        = number
  default     = 2048
}
variable "subject" {
  description = "The subject of the certificate. Required if type is 'self-signed'."
  type = object({
    common_name         = string
    country             = string
    locality            = optional(string)
    organization        = string
    organizational_unit = string
    province            = string
    postal_code         = optional(string)
    street_address      = optional(list(string), [])
    serial_number       = optional(string)
  })
}
variable "validity_period_hours" {
  description = "The number of hours after initial issuance that the certificate will become invalid. Defaults to 8760 (one year)."
  type        = number
  default     = 8760
}
variable "early_renewal_hours" {
  description = "The number of hours before expiration that the certificate will be renewed. Defaults to 720 (30 days)."
  type        = number
  default     = 720
}
variable "allowed_uses" {
  description = "A list of allowed uses for the certificate."
  type        = list(string)
  default     = ["server_auth"]
}
variable "uris" {
  description = "A list of URIs to use for the SAN extension."
  type        = list(string)
  default     = []
}
variable "dns_names" {
  description = "A list of DNS names to use for the SAN extension."
  type        = list(string)
  default     = []
}
