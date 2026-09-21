# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "database" {
  description = "Name of the existing database to grant access on."
  type        = string
}

variable "role" {
  description = "Name of the existing role to receive the grants."
  type        = string
}

variable "database_privileges" {
  description = "Privileges to grant at the database level (e.g. CONNECT, CREATE, TEMPORARY)."
  type        = list(string)
  default     = ["CONNECT"]
}

variable "schema_privileges" {
  description = "Privileges to grant on the schema (e.g. USAGE, CREATE). Set to [] to skip the schema grant."
  type        = list(string)
  default     = ["USAGE"]
}

variable "schema" {
  description = "Schema to grant access on. Ignored when schema_privileges is empty."
  type        = string
  default     = "public"
}
