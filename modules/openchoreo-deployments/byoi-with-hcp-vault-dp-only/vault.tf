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

# READ the existing AppRole roles from the restored Vault (do NOT create — the restore
# already brought back the backend/roles/policies/KV) and issue fresh secret_ids so
# external-secrets can log in.

data "vault_approle_auth_backend_role_id" "read" {
  backend   = var.approle_backend
  role_name = var.external_secrets_read_role_name
}
resource "vault_approle_auth_backend_role_secret_id" "read" {
  backend   = var.approle_backend
  role_name = var.external_secrets_read_role_name
}

data "vault_approle_auth_backend_role_id" "write" {
  backend   = var.approle_backend
  role_name = var.external_secrets_write_role_name
}
resource "vault_approle_auth_backend_role_secret_id" "write" {
  backend   = var.approle_backend
  role_name = var.external_secrets_write_role_name
}

data "vault_approle_auth_backend_role_id" "application_read" {
  backend   = var.approle_backend
  role_name = var.external_secrets_application_read_role_name
}
resource "vault_approle_auth_backend_role_secret_id" "application_read" {
  backend   = var.approle_backend
  role_name = var.external_secrets_application_read_role_name
}
