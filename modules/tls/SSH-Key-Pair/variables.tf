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

variable "algorithm" {
  description = "The algorithm to use for the private key. Supported values: RSA, ED25519."
  type        = string
  default     = "RSA"
  validation {
    condition     = contains(["RSA", "ED25519"], var.algorithm)
    error_message = "algorithm must be RSA or ED25519."
  }
}

variable "rsa_bits" {
  description = "The number of bits in the generated RSA key. Only used when algorithm is RSA."
  type        = number
  default     = 2048
}
