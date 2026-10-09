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
  # DDL users switch to their database's owner role at login, so objects they
  # create are owned by <db>_owner (alterable by the database's other DDL users
  # and by db_owner_role_name, and covered by the default grants below).
  assume_role = contains(keys(local.ddl_user_db), each.key) ? local.db_owner_roles[local.ddl_user_db[each.key]] : null

  lifecycle {
    # Role memberships are managed by postgresql_grant_role.db_owner_membership;
    # without this, the two resources fight over the role's memberships.
    ignore_changes = [roles]
  }
}

resource "postgresql_database" "dbs" {
  for_each = var.databases

  name     = each.key
  owner    = var.db_owner_role_name
  encoding = "UTF8"
}

# Extensions are created by the provider's admin role since application users
# lack the database-level CREATE privilege required by CREATE EXTENSION.
resource "postgresql_extension" "extensions" {
  for_each = local.ext_map

  name     = each.value.extension
  database = postgresql_database.dbs[each.value.database_name].name
}

# ==========================================
# DB OWNER ROLE MEMBERSHIP
# ==========================================

resource "postgresql_grant_role" "db_owner_membership" {
  for_each = toset(var.db_owner_member_users)

  role              = postgresql_role.db_users[each.key].name
  grant_role        = var.db_owner_role_name
  with_admin_option = false
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

# ==========================================
# PER-DATABASE OWNER ROLES (per_database_owner = true)
# ==========================================

# NOLOGIN role that owns one database's objects. db_owner_role_name stays the
# database owner, so DDL users can alter/drop their objects but never the
# database itself.
resource "postgresql_role" "database_owners" {
  for_each = local.db_owner_roles
  name     = each.value
  login    = false

  lifecycle {
    ignore_changes = [roles]
  }
}

# db_owner_role_name (the SRE login) reaches every database's objects through
# inheriting ADMIN membership in each owner role — one credential for all.
resource "postgresql_grant_role" "system_user_database_owner" {
  for_each = local.db_owner_roles

  role              = var.db_owner_role_name
  grant_role        = postgresql_role.database_owners[each.key].name
  with_admin_option = true
}

resource "postgresql_grant_role" "ddl_user_database_owner" {
  for_each = var.per_database_owner ? local.ddl_user_db : {}

  role              = postgresql_role.db_users[each.key].name
  grant_role        = postgresql_role.database_owners[each.value].name
  with_admin_option = false
}

# db_owner_role_name's sessions in each database switch to that database's
# owner role, so objects SRE creates are owned by <db>_owner like the app's.
# The provider has no resource for a per-database role setting, so this runs
# through psql with the admin connection (credentials only in the environment,
# never in the command line or state). Re-applied when the names change;
# Terraform does not detect it being reset by hand.
resource "terraform_data" "system_user_database_role" {
  for_each = local.db_owner_roles

  triggers_replace = [each.key, var.db_owner_role_name, each.value]

  provisioner "local-exec" {
    command = "psql -X -v ON_ERROR_STOP=1 -c \"$SQL\""
    environment = {
      PGHOST     = var.db_admin_connection.host
      PGPORT     = tostring(var.db_admin_connection.port)
      PGUSER     = var.db_admin_connection.username
      PGPASSWORD = var.db_admin_connection.password
      PGSSLMODE  = var.db_admin_connection.sslmode
      PGDATABASE = "postgres"
      SQL        = format("ALTER ROLE %s IN DATABASE %s SET role = %s", jsonencode(var.db_owner_role_name), jsonencode(each.key), jsonencode(each.value))
    }
  }

  depends_on = [
    postgresql_database.dbs,
    postgresql_grant_role.system_user_database_owner,
  ]
}

# Default grants for objects created by the per-database owner role — i.e.
# everything created by DDL users or by db_owner_role_name after enabling.
resource "postgresql_default_privileges" "owner_revoke_public_future_functions" {
  for_each = local.db_owner_roles

  database    = postgresql_database.dbs[each.key].name
  role        = "public"
  schema      = "public"
  owner       = postgresql_role.database_owners[each.key].name
  object_type = "function"
  privileges  = []
}

resource "postgresql_default_privileges" "owner_ro_future_tables" {
  for_each = var.per_database_owner ? local.ro_map : {}

  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = postgresql_role.database_owners[each.value.database_name].name
  object_type = "table"
  privileges  = ["SELECT"]
}

resource "postgresql_default_privileges" "owner_rw_future_tables" {
  for_each = var.per_database_owner ? local.rw_map : {}

  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = postgresql_role.database_owners[each.value.database_name].name
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}

resource "postgresql_default_privileges" "owner_rw_future_sequences" {
  for_each = var.per_database_owner ? local.rw_map : {}

  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = postgresql_role.database_owners[each.value.database_name].name
  object_type = "sequence"
  privileges  = ["USAGE", "SELECT", "UPDATE"]
}

resource "postgresql_default_privileges" "owner_rw_future_functions" {
  for_each = var.per_database_owner ? local.rw_map : {}

  database    = postgresql_database.dbs[each.value.database_name].name
  role        = postgresql_role.db_users[each.value.user].name
  schema      = "public"
  owner       = postgresql_role.database_owners[each.value.database_name].name
  object_type = "routine"
  privileges  = ["EXECUTE"]
}
