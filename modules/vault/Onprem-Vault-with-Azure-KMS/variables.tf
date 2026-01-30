# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "client_identifier" {
  description = "A unique identifier for naming resources related to Vault auto-unseal using Azure KMS."
  type        = string
}
variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
}
variable "resource_group" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}
variable "secret1_rotation_time_in_months" {
  description = "The rotation time in months for the first secret."
  type        = number
  default     = 12
}
variable "secret2_rotation_offset_in_months" {
  description = "The rotation time in months for the second secret."
  type        = number
  default     = 6
}
