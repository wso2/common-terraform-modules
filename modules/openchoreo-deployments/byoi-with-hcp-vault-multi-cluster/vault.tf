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
  is_vault          = var.secret_store_type == "vault"
  registry_username = local.is_harbor ? harbor_robot_account.openchoreo_system_user[0].full_name : var.docker_registry_username
  registry_password = local.is_harbor ? random_password.openchoreo_cr_system_user_password[0].result : var.docker_registry_password
  registry_auth     = base64encode("${local.registry_username}:${local.registry_password}")
}

module "auth-backend-approle" {
  count  = local.is_vault ? 1 : 0
  source = "../../vault/Vault-Auth-Backend"
  type   = "approle"
}

module "secrets-mount" {
  count  = local.is_vault ? 1 : 0
  source = "../../vault/Vault-Mount"
  path   = var.secrets_mount_path
}

module "external-secrets-default-vault-read-policy" {
  count             = local.is_vault ? 1 : 0
  source            = "../../vault/Vault-Policy"
  policy_name       = var.external_secrets_vault_read_policy_name
  policy_definition = <<EOT
path "${module.secrets-mount[0].path}/*" {
  capabilities = ["read", "list"]
}
path "${module.secrets-mount[0].path}/metadata/*" {
  capabilities = ["list"]
}
EOT
  depends_on = [
    module.secrets-mount
  ]
}

module "external-secrets-automation-vault-write-policy" {
  count             = local.is_vault ? 1 : 0
  source            = "../../vault/Vault-Policy"
  policy_name       = var.external_secrets_vault_write_policy_name
  policy_definition = <<EOT
path "${module.secrets-mount[0].path}/data/automation/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}
path "${module.secrets-mount[0].path}/metadata/automation/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}
EOT
  depends_on = [
    module.secrets-mount
  ]
}

module "external-secrets-read-app-role" {
  count              = local.is_vault ? 1 : 0
  source             = "../../vault/Dynamic-Vault-AppRole-Auth-Backend-Role"
  backend            = module.auth-backend-approle[0].path
  role_name          = var.external_secrets_read_role_name
  token_policies     = [module.external-secrets-default-vault-read-policy[0].policy_name]
  secret_id_ttl      = 157680000
  token_type         = "default"
  token_ttl          = 3600
  token_max_ttl      = 10800
  secret_id_num_uses = 0

  depends_on = [
    module.auth-backend-approle,
    module.external-secrets-default-vault-read-policy
  ]
}

module "external-secrets-write-app-role" {
  count              = local.is_vault ? 1 : 0
  source             = "../../vault/Dynamic-Vault-AppRole-Auth-Backend-Role"
  backend            = module.auth-backend-approle[0].path
  role_name          = var.external_secrets_write_role_name
  token_policies     = [module.external-secrets-automation-vault-write-policy[0].policy_name]
  secret_id_ttl      = 157680000
  token_type         = "default"
  token_ttl          = 3600
  token_max_ttl      = 10800
  secret_id_num_uses = 0

  depends_on = [
    module.auth-backend-approle,
    module.external-secrets-automation-vault-write-policy
  ]
}

resource "vault_kv_secret_v2" "registry_credentials" {
  count = local.is_vault ? 1 : 0
  mount = module.secrets-mount[0].path
  name  = "registry-credentials"
  data_json = jsonencode(
    {
      "dockerconfigjson" = jsonencode(
        {
          auths = {
            (var.docker_registry_host) = {
              username = local.registry_username
              password = local.registry_password
              auth     = local.registry_auth
            }
          }
        }
      )
    }
  )
  depends_on = [
    module.secrets-mount
  ]
}
