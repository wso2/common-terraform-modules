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

resource "random_password" "user_passwords" {
  for_each         = local.all_unique_users
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "postgresql_role" "db_users" {
  for_each = local.all_unique_users
  name     = each.key
  login    = true
  password = random_password.user_passwords[each.key].result
}

resource "postgresql_database" "dbs" {
  for_each = var.databases

  name     = each.key
  owner    = var.db_owner_role_name
  encoding = "UTF8"
}

# ==========================================
# SECURITY: REVOKE PUBLIC EXECUTE GRANTS
# ==========================================

# 1. Revoke EXECUTE from PUBLIC on EXISTING functions
resource "postgresql_grant" "revoke_public_functions" {
  for_each = var.databases

  database    = postgresql_database.dbs[each.key].name
  role        = "public" # The built-in Postgres role
  schema      = "public"
  object_type = "function"
  privileges  = [] # An empty list forces Terraform to REVOKE privileges
}

# 2. Revoke EXECUTE from PUBLIC on FUTURE functions created by the system owner
resource "postgresql_default_privileges" "revoke_public_future_functions" {
  for_each = var.databases

  database    = postgresql_database.dbs[each.key].name
  role        = "public"
  schema      = "public"
  owner       = var.db_owner_role_name
  object_type = "function"
  privileges  = [] # Overrides the Postgres default, revoking future access
}

# ==========================================
# READ-ONLY GRANTS
# ==========================================

resource "postgresql_grant" "ro_connect" {
  for_each    = local.ro_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "database"
  privileges  = ["CONNECT"]
}

resource "postgresql_grant" "ro_schema" {
  for_each    = local.ro_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE"]
}

resource "postgresql_grant" "ro_tables" {
  for_each    = local.ro_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT"]
}

resource "postgresql_default_privileges" "ro_future_tables" {
  for_each    = local.ro_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = var.db_owner_role_name
  object_type = "table"
  privileges  = ["SELECT"]
}

# ==========================================
# READ-WRITE GRANTS
# ==========================================

resource "postgresql_grant" "rw_connect" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "database"
  privileges  = ["CONNECT"]
}

resource "postgresql_grant" "rw_schema" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "schema"
  privileges  = ["USAGE", "CREATE"]
}

resource "postgresql_grant" "rw_tables" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}

resource "postgresql_grant" "rw_sequences" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "sequence"
  privileges  = ["USAGE", "SELECT", "UPDATE"]
}

resource "postgresql_default_privileges" "rw_future_tables" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = var.db_owner_role_name
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}

# 6. Grant USAGE/UPDATE on FUTURE sequences
resource "postgresql_default_privileges" "rw_future_sequences" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = var.db_owner_role_name
  object_type = "sequence"
  privileges  = ["USAGE", "SELECT", "UPDATE"]
}

# 7. Grant EXECUTE on EXISTING functions
resource "postgresql_grant" "rw_functions" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  object_type = "routine"
  privileges  = ["EXECUTE"]
}

# 8. Grant EXECUTE on FUTURE functions
resource "postgresql_default_privileges" "rw_future_functions" {
  for_each    = local.rw_map
  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = var.db_owner_role_name
  object_type = "routine"
  privileges  = ["EXECUTE"]
}
