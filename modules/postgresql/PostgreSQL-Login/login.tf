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

resource "postgresql_role" "role" {
  name             = var.user_name
  login            = var.login_enabled
  connection_limit = var.connection_limit
  password         = var.password
  roles            = var.roles
  inherit          = var.inherit
}

resource "postgresql_grant" "permissions" {
  for_each    = var.permissions
  database    = var.db_name
  role        = postgresql_role.role.name
  schema      = each.value.schema
  object_type = each.value.object_type
  objects     = each.value.object_type == "database" || each.value.object_type == "schema" ? null: each.value.objects
  privileges  = each.value.privileges
  columns     = each.value.object_type == "column" ? each.value.columns : null
}