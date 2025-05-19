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

resource "postgresql_database" "db" {
  name              = var.db_name
  owner             = var.db_owner
  template          = var.template
  lc_collate        = var.lc_collate
  connection_limit  = var.connection_limit
  allow_connections = var.allow_connections
}
