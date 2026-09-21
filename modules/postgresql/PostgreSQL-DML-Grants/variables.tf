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

variable "owner" {
  description = "Role that owns the schema objects. Used for ALTER DEFAULT PRIVILEGES so that objects this owner creates in the future automatically inherit the same grants."
  type        = string
}

variable "schema" {
  description = "Schema to grant access on."
  type        = string
  default     = "public"
}

# ---- Privilege overrides ----
# Defaults match the DML-only (least-privilege runtime) pattern.
# Override per-variable to dial up or down without touching the module source.
#
# Common presets:
#   Read-only  : table_privileges = ["SELECT"], sequence_privileges = []
#   DML        : (defaults below)
#   Full access: schema_privileges = ["USAGE","CREATE"],
#                sequence_privileges = ["USAGE","SELECT","UPDATE"]

variable "database_privileges" {
  description = "Privileges to grant at the database level."
  type        = list(string)
  default     = ["CONNECT"]
}

variable "schema_privileges" {
  description = "Privileges to grant on the schema."
  type        = list(string)
  default     = ["USAGE"]
}

variable "table_privileges" {
  description = "Privileges to grant on existing tables."
  type        = list(string)
  default     = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}

variable "sequence_privileges" {
  description = "Privileges to grant on existing sequences. Set to [] if the role does not need sequence access."
  type        = list(string)
  default     = ["USAGE", "SELECT"]
}

variable "future_table_privileges" {
  description = "Default privileges for tables the owner creates in the future. Mirrors table_privileges when not overridden."
  type        = list(string)
  default     = null
}

variable "future_sequence_privileges" {
  description = "Default privileges for sequences the owner creates in the future. Mirrors sequence_privileges when not overridden."
  type        = list(string)
  default     = null
}
