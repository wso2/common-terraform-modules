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

variable "db_name" {
  description = "Name of the database to be created."
  type        = string
}
variable "db_owner" {
  description = "Owner of the database."
  type        = string
}
variable "template" {
  description = "Template to use for the database."
  type        = string
  default     = "template0"
}
variable "lc_collate" {
  description = "LC_COLLATE setting for the database."
  type        = string
  default     = null
}
variable "connection_limit" {
  description = "Connection limit for the database."
  type        = number
  default     = -1
}
variable "allow_connections" {
  description = "Allow connections to the database."
  type        = bool
  default     = true
}