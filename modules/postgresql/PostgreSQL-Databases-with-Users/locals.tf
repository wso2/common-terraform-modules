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
  # 1. Extract a unique list of all users across all databases so we can create their roles
  all_ro_users     = flatten([for db, config in var.databases : config.read_only_users])
  all_rw_users     = flatten([for db, config in var.databases : config.read_write_users])
  all_ddl_users    = flatten([for db, config in var.databases : config.ddl_users])
  all_unique_users = toset(concat(local.all_ro_users, local.all_rw_users, local.all_ddl_users))

  # Per-database owner roles (per_database_owner only): database => role name.
  db_owner_roles = var.per_database_owner ? { for db, config in var.databases : db => "${db}_owner" } : {}

  # DDL user => its (single, validated) database.
  ddl_user_db = merge([for db, config in var.databases : { for user in config.ddl_users : user => db }]...)

  # 2. Flatten for Read-Only Grants
  db_readonly = flatten([
    for db, config in var.databases : [
      for user in config.read_only_users : {
        database_name = db
        user          = user
      }
    ]
  ])
  ro_map = { for pair in local.db_readonly : "${pair.database_name}-${pair.user}" => pair }

  # 3. Flatten for Read-Write Grants
  # DDL users also get every read-write grant (DDL is on top of write).
  db_readwrite = flatten([
    for db, config in var.databases : [
      for user in concat(config.read_write_users, config.ddl_users) : {
        database_name = db
        user          = user
      }
    ]
  ])
  rw_map = { for pair in local.db_readwrite : "${pair.database_name}-${pair.user}" => pair }

  # 4. Flatten for Extensions
  db_extensions = flatten([
    for db, config in var.databases : [
      for ext in config.extensions : {
        database_name = db
        extension     = ext
      }
    ]
  ])
  ext_map = { for pair in local.db_extensions : "${pair.database_name}-${pair.extension}" => pair }
}
