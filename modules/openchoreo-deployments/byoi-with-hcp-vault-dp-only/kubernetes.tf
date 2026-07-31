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

# external-secrets namespace + the AppRole login secrets it uses to reach Vault.
module "namespace" {
  source = "../../kubernetes/Namespaces"
  kubernetes_namespaces = {
    (var.external_secrets_namespace) = {}
  }
}

module "external-secrets-approle-creds" {
  source    = "../../kubernetes/Secrets"
  namespace = var.external_secrets_namespace
  secrets = {
    approle-creds-read-permission = {
      data = {
        role_id   = data.vault_approle_auth_backend_role_id.read.role_id
        secret_id = vault_approle_auth_backend_role_secret_id.read.secret_id
      }
    }
    approle-creds-write-permission = {
      data = {
        role_id   = data.vault_approle_auth_backend_role_id.write.role_id
        secret_id = vault_approle_auth_backend_role_secret_id.write.secret_id
      }
    }
    approle-creds-application-read-permission = {
      data = {
        role_id   = data.vault_approle_auth_backend_role_id.application_read.role_id
        secret_id = vault_approle_auth_backend_role_secret_id.application_read.secret_id
      }
    }
  }
  depends_on = [module.namespace]
}
