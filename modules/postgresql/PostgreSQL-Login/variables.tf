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

variable "user_name" {
  description = "The name of the PostgreSQL user to be created."
  type        = string
}
variable "db_name" {
  description = "The name of the PostgreSQL database to be created."
  type        = string
}
variable "login_enabled" {
  description = "Flag to enable or disable the PostgreSQL login."
  type        = bool
  default     = true
}
variable "connection_limit" {
  description = "The maximum number of concurrent connections allowed for the PostgreSQL user."
  type        = number
  default     = -1
}
variable "password" {
  description = "The password for the PostgreSQL user."
  type        = string
  sensitive   = true
}
variable "roles" {
  description = "List of roles to be assigned to the PostgreSQL user."
  type        = list(string)
  default     = []
}
variable "inherit" {
  description = "Flag to indicate whether the PostgreSQL user inherits privileges from roles."
  type        = bool
  default     = true
}
variable "permissions" {
  description = "Map of permissions to be granted to the PostgreSQL user."
  type = map(object({
    schema      = string
    object_type = string
    objects     = optional(list(string), [])
    privileges  = list(string)
    columns     = optional(list(string), [])
  }))
  default = {}
}
