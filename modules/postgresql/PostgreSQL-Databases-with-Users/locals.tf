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
  all_unique_users = toset(concat(local.all_ro_users, local.all_rw_users))

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
  db_readwrite = flatten([
    for db, config in var.databases : [
      for user in config.read_write_users : {
        database_name = db
        user          = user
      }
    ]
  ])
  rw_map = { for pair in local.db_readwrite : "${pair.database_name}-${pair.user}" => pair }
}
