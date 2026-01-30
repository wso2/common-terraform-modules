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

data "azurerm_client_config" "current" {}

locals {
  suffix             = "-unseal-vault"
  max_name_len       = 24
  allowed_prefix_len = max(0, local.max_name_len - length(local.suffix))
  raw_id             = regexreplace(lower(var.client_identifier), "[^a-z0-9-]", "")
  safe_id            = trim(local.raw_id, "-")
  truncated_id       = substr(local.safe_id, 0, local.allowed_prefix_len)
  vault_name         = length(local.truncated_id) > 0 ? "${local.truncated_id}${local.suffix}" : "kv${local.suffix}"
}

resource "azuread_application" "vault_unseal_entra_app" {
  display_name = "${var.client_identifier}-vault-onprem-unseal"
}

resource "azuread_service_principal" "vault_unseal_entra_app" {
  client_id  = azuread_application.vault_unseal_entra_app.client_id
  depends_on = [azuread_application.vault_unseal_entra_app]
}

#trivy:ignore:AVD-AZU-0013
resource "azurerm_key_vault" "unseal_vault" {
  name                       = local.vault_name
  location                   = var.location
  resource_group_name        = var.resource_group
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Update"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azuread_service_principal.vault_unseal_entra_app.object_id

    key_permissions = [
      "Get",
      "List",
      "Decrypt",
      "Encrypt",
      "Sign",
      "Verify",
      "Backup",
      "Update",
      "WrapKey",
      "UnwrapKey"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]
  }
  depends_on = [
    azuread_service_principal.vault_unseal_entra_app
  ]
}

#trivy:ignore:AVD-AZU-0014
resource "azurerm_key_vault_key" "unseal_key" {
  name         = "vault-unseal-key"
  key_vault_id = azurerm_key_vault.unseal_vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  depends_on = [
    azurerm_key_vault.unseal_vault
  ]
}

resource "time_rotating" "time_rotating_1" {
  rotation_months = var.secret1_rotation_time_in_months
}

resource "time_rotating" "time_rotating_2" {
  rfc3339         = time_rotating.time_rotating_1.rotation_rfc3339
  rotation_months = var.secret2_rotation_offset_in_months

  lifecycle {
    ignore_changes = [rfc3339]
  }
}

resource "azuread_application_password" "application_password_1" {
  application_id = azuread_application.vault_unseal_entra_app.id
  display_name   = "terraform-${time_rotating.time_rotating_1.rotation_rfc3339}-1"
  end_date       = timeadd(time_rotating.time_rotating_1.rotation_rfc3339, "720h")

  rotate_when_changed = {
    rotation = time_rotating.time_rotating_1.id
  }
  lifecycle {
    ignore_changes = [end_date]
  }
}

resource "azuread_application_password" "application_password_2" {
  application_id = azuread_application.vault_unseal_entra_app.id
  display_name   = "terraform-${time_rotating.time_rotating_2.rotation_rfc3339}-2"
  end_date       = timeadd(time_rotating.time_rotating_2.rotation_rfc3339, "720h")

  rotate_when_changed = {
    rotation = time_rotating.time_rotating_2.id
  }
  lifecycle {
    ignore_changes = [end_date]
  }
}
