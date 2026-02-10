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
  registry_username = local.is_harbor ? harbor_robot_account.openchoreo_system_user[0].name : var.docker_registry_username
  registry_password = local.is_harbor ? random_password.openchoreo_cr_system_user_password[0].result : var.docker_registry_password
  registry_auth     = base64encode("${local.registry_username}:${local.registry_password}")
}

module "auth-backend-approle" {
  source = "../../vault/Vault-Auth-Backend"
  type   = "approle"
}

module "secrets-mount" {
  source = "../../vault/Vault-Mount"
  path   = "secrets"
}

module "external-secrets-default-vault-read-policy" {
  source            = "../../vault/Vault-Policy"
  policy_name       = "external-secrets-default-read-policy"
  policy_definition = <<EOT
path "${module.secrets-mount.path}/*" {
  capabilities = ["read", "list"]
}
path "${module.secrets-mount.path}/metadata/*" {
  capabilities = ["list"]
}
EOT
  depends_on = [
    module.secrets-mount
  ]
}

module "external-secrets-automation-vault-write-policy" {
  source            = "../../vault/Vault-Policy"
  policy_name       = "external-secrets-automation-write-policy"
  policy_definition = <<EOT
path "${module.secrets-mount.path}/data/automation/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}
path "${module.secrets-mount.path}/metadata/automation/*" {
  capabilities = ["create", "update", "patch", "delete", "read", "list"]
}
EOT
  depends_on = [
    module.secrets-mount
  ]
}

module "external-secrets-read-app-role" {
  source             = "../../vault/Dynamic-Vault-AppRole-Auth-Backend-Role"
  backend            = module.auth-backend-approle.path
  role_name          = "external-secrets-read"
  token_policies     = [module.external-secrets-default-vault-read-policy.policy_name]
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
  source             = "../../vault/Dynamic-Vault-AppRole-Auth-Backend-Role"
  backend            = module.auth-backend-approle.path
  role_name          = "external-secrets-write"
  token_policies     = [module.external-secrets-automation-vault-write-policy.policy_name]
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
  mount = module.secrets-mount.path
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
