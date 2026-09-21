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

locals {
  future_table_privs    = var.future_table_privileges != null ? var.future_table_privileges : var.table_privileges
  future_sequence_privs = var.future_sequence_privileges != null ? var.future_sequence_privileges : var.sequence_privileges
}

resource "postgresql_grant" "connect" {
  database    = var.database
  role        = var.role
  object_type = "database"
  privileges  = var.database_privileges
}

resource "postgresql_grant" "schema_usage" {
  database    = var.database
  role        = var.role
  schema      = var.schema
  object_type = "schema"
  privileges  = var.schema_privileges
}

resource "postgresql_grant" "table_dml" {
  database    = var.database
  role        = var.role
  schema      = var.schema
  object_type = "table"
  privileges  = var.table_privileges
}

resource "postgresql_grant" "sequence_dml" {
  count = length(var.sequence_privileges) > 0 ? 1 : 0

  database    = var.database
  role        = var.role
  schema      = var.schema
  object_type = "sequence"
  privileges  = var.sequence_privileges
}

resource "postgresql_default_privileges" "future_tables" {
  database    = var.database
  role        = var.role
  schema      = var.schema
  owner       = var.owner
  object_type = "table"
  privileges  = local.future_table_privs
}

resource "postgresql_default_privileges" "future_sequences" {
  count = length(local.future_sequence_privs) > 0 ? 1 : 0

  database    = var.database
  role        = var.role
  schema      = var.schema
  owner       = var.owner
  object_type = "sequence"
  privileges  = local.future_sequence_privs
}
