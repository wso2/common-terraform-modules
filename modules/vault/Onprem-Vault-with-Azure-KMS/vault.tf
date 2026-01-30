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

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = "vault"
  version    = "0.32.0"

  values = [<<EOF
server:
  extraSecretEnvironmentVars:
    - envName: AZURE_TENANT_ID
      secretName: vault-azure-creds
      secretKey: AZURE_TENANT_ID
    - envName: AZURE_CLIENT_ID
      secretName: vault-azure-creds
      secretKey: AZURE_CLIENT_ID
    - envName: AZURE_CLIENT_SECRET
      secretName: vault-azure-creds
      secretKey: AZURE_CLIENT_SECRET
  ha:
    enabled: true
    raft:
      enabled: true
      setNodeId: true
  config: |
    ui = true
    listener "tcp" {
      address = "[::]:8200"
      cluster_address = "[::]:8201"
      tls_disable = 1
    }
    storage "raft" {
      path = "/vault/data"
    }
    seal "azurekeyvault" {
      vault_name     = "${azurerm_key_vault.unseal_vault.name}"
      key_name       = "${azurerm_key_vault_key.unseal_key.name}"
    }
EOF
  ]
  depends_on = [
    kubernetes_namespace_v1.vault,
    kubernetes_secret_v1.vault_azure_creds,
    azurerm_key_vault.unseal_vault,
    azurerm_key_vault_key.unseal_key
  ]
}
