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

resource "vault_auth_backend" "approle" {
  type = "approle"
  tune {
    max_lease_ttl     = var.vault_auth_backend_max_lease_ttl
    default_lease_ttl = var.vault_auth_backend_default_lease_ttl
  }
}

resource "vault_approle_auth_backend_role" "app_role" {
  backend            = vault_auth_backend.approle.path
  role_name          = var.role_name
  token_policies     = var.token_policies
  bind_secret_id     = var.bind_secret_id
  secret_id_ttl      = var.secret_id_ttl
  token_type         = var.token_type
  token_ttl          = var.token_ttl
  token_max_ttl      = var.token_max_ttl
  secret_id_num_uses = var.secret_id_num_uses
}

resource "time_rotating" "secret_id_1" {
  rotation_months = var.secret_id_1_rotation_time_in_months
}

resource "time_rotating" "secret_id_2" {
  rotation_months = var.secret_id_2_rotation_time_in_months
}

resource "vault_approle_auth_backend_role_secret_id" "secret_id_1" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.app_role.role_name
  ttl       = var.secret_id_ttl
  metadata = jsonencode(
    {
      rotation_time = time_rotating.secret_id_1.id
    }
  )
  depends_on = [time_rotating.secret_id_1]
}

resource "vault_approle_auth_backend_role_secret_id" "secret_id_2" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.app_role.role_name
  ttl       = var.secret_id_ttl
  metadata = jsonencode(
    {
      rotation_time = time_rotating.secret_id_1.id
    }
  )
  depends_on = [time_rotating.secret_id_2]
}
