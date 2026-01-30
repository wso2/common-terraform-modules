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

resource "kubernetes_namespace_v1" "vault" {
  metadata {
    name = "vault"
  }
}

resource "kubernetes_secret_v1" "vault_azure_creds" {
  metadata {
    name      = "vault-azure-creds"
    namespace = kubernetes_namespace_v1.vault.metadata[0].name
  }

  data = {
    AZURE_TENANT_ID     = data.azurerm_client_config.current.tenant_id
    AZURE_CLIENT_ID     = azuread_application.vault_unseal_entra_app.client_id
    AZURE_CLIENT_SECRET = time_rotating.time_rotating_1.unix > time_rotating.time_rotating_2.unix ? azuread_application_password.application_password_1.value : azuread_application_password.application_password_2.value
  }

  type = "Opaque"
  depends_on = [
    kubernetes_namespace_v1.vault,
    azuread_application.vault_unseal_entra_app,
    azuread_application_password.application_password_1,
    azuread_application_password.application_password_2
  ]
}

resource "kubernetes_job_v1" "vault_init" {
  metadata {
    name      = "vault-init"
    namespace = kubernetes_namespace_v1.vault.metadata[0].name
  }

  spec {
    template {
      metadata {
        labels = {
          app = "vault-init"
        }
      }
      spec {
        # Using Azure CLI as the base image
        container {
          name  = "init-and-upload"
          image = "mcr.microsoft.com/azure-cli:2.82.0"

          env {
            name  = "VAULT_ADDR"
            value = "http://vault-0.vault-internal:8200"
          }
          # Injecting the Service Principal credentials created earlier
          env {
            name = "AZURE_CLIENT_ID"
            value_from {
              secret_key_ref {
                name = "vault-azure-creds"
                key  = "AZURE_CLIENT_ID"
              }
            }
          }
          env {
            name = "AZURE_CLIENT_SECRET"
            value_from {
              secret_key_ref {
                name = "vault-azure-creds"
                key  = "AZURE_CLIENT_SECRET"
              }
            }
          }
          env {
            name = "AZURE_TENANT_ID"
            value_from {
              secret_key_ref {
                name = "vault-azure-creds"
                key  = "AZURE_TENANT_ID"
              }
            }
          }

          command = ["/bin/sh", "-c"]
          args = [
            <<-EOT
            set -e
            # 1. Install Vault binary
            echo "Installing Vault binary..."
            VAULT_VERSION="1.21.2"
            apk add --no-cache curl unzip
            curl -sSL "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" -o vault.zip
            curl -sSL "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS" -o vault_checksums.txt
            grep "vault_${VAULT_VERSION}_linux_amd64.zip" vault_checksums.txt | sha256sum -c -
            unzip vault.zip && mv vault /usr/local/bin/ && rm vault.zip vault_checksums.txt

            # 2. Wait for Vault pod to be reachable
            echo "Waiting for vault-0.vault-internal..."
            TIMEOUT=300
            ELAPSED=0
            until curl -s $VAULT_ADDR/v1/sys/health > /dev/null; do
              if [ $ELAPSED -ge $TIMEOUT ]; then
                echo "Timeout waiting for Vault to become healthy"
                exit 1
              fi
               sleep 5
              ELAPSED=$((ELAPSED + 5))
            done

            # 3. Check initialization status
            # Status 200 = init, 501 = not init, 503 = sealed (but with auto-unseal it should unseal)
            INIT_STATUS=$(curl -s -o /dev/null -w "%%{http_code}" $VAULT_ADDR/v1/sys/init)

            if [ "$INIT_STATUS" -eq "501" ]; then
              echo "Vault is not initialized. Starting initialization..."

              # Initialize and capture JSON
              vault operator init -format=json > /tmp/keys.json

              # 4. Login to Azure using Service Principal
              echo "Logging into Azure..."
              az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

              # 5. Upload to Key Vault
              echo "Uploading keys to Azure Key Vault..."
              az keyvault secret set \
                --vault-name ${azurerm_key_vault.unseal_vault.name} \
                --name "vault-init-output" \
                --file "/tmp/keys.json" \
                --description "Vault recovery keys and root token generated on $(date)"
              rm -f /tmp/keys.json
              echo "Initialization successful and keys backed up."
            else
              echo "Vault is already initialized (Status: $INIT_STATUS). Skipping."
            fi
            EOT
          ]
        }
        restart_policy = "OnFailure"
      }
    }
    # Ensure the Job doesn't keep running if it fails once
    backoff_limit = 4
  }

  depends_on = [
    helm_release.vault,
    kubernetes_secret_v1.vault_azure_creds
  ]
}
