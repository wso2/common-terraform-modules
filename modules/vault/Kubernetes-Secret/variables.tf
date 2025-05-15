# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "secrets_map" {
  description = "Map of secrets to be created"
  type = map(object({
    name      = string
    namespace = string
    data      = map(string)
  }))
  default = {}
}
variable "namespace" {
  description = "Namespace to create the secrets in"
  type        = string
}
variable "workload_name" {
  description = "Name of the secret"
  type        = string
}
variable "service_account_name" {
  description = "Name of the service account"
  type        = string
  default     = null
}
variable "permissions" {
  description = "Permissions for the secret"
  type        = string
  default     = "read"
}
variable "backend" {
  description = "Backend for the secret"
  type        = string
}
variable "create_rbac" {
  description = "Create RBAC for the secret"
  type        = bool
  default     = true
}
