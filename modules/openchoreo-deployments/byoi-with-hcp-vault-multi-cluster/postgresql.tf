# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

locals {
  databases   = toset(["thunderdb", "runtimedb", "userdb", "backstage"])
  is_postgres = var.oc_system_db_type == "postgres"
}

ephemeral "random_password" "oc_system_db_password" {
  # Create the random password only when using Postgres
  count            = local.is_postgres ? 1 : 0
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "postgresql_role" "oc_system_db_user" {
  # Create role only for Postgres
  count = local.is_postgres ? 1 : 0

  name  = var.oc_system_db_username
  login = true
  # When created, the password resource will exist at index 0
  password_wo         = ephemeral.random_password.oc_system_db_password[0].result
  password_wo_version = var.oc_system_db_password_version
  create_database     = true
}

resource "postgresql_database" "oc_system_dbs" {
  # When not Postgres, iterate an empty map so no databases are created
  for_each = local.is_postgres ? local.databases : toset([])
  name     = each.key

  # SETTING THE OWNER IS KEY
  # By making thunder_db_user the owner, they inherently have:
  # - READ/WRITE privileges
  # - ALTER privileges (Create/Drop tables)
  # - ACCESS to the public schema
  owner = postgresql_role.oc_system_db_user[0].name

  encoding = "UTF8"
}

resource "kubernetes_secret_v1" "thunder_db_credentials" {
  count = local.is_postgres ? 1 : 0
  metadata {
    name      = "thunder-db-credentials"
    namespace = "flux-system"
  }

  data_wo = {
    thunder_db_username = var.oc_system_db_username
    thunder_db_password = ephemeral.random_password.oc_system_db_password[0].result
  }

  data_wo_revision = var.oc_system_db_password_version

  type = "Opaque"
}
