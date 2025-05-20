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

resource "vault_kv_secret_v2" "secrets" {
  count = length(keys(var.secrets_map)) > 0 ? 1 : 0

  mount     = vault_mount.vault_mount.path
  name      = "${var.namespace}/${var.workload_name}"
  data_json = jsonencode(var.secrets_map)
}

resource "vault_mount" "vault_mount" {
  path = "${var.namespace}/${var.workload_name}"
  type = "kv-v2"
  options = {
    type    = "kv-v2"
    version = "2"
  }
  description = "Secrets of ${var.workload_name} in ${var.namespace}"
}
resource "vault_kv_secret_backend_v2" "secret_backend" {
  mount        = vault_mount.vault_mount.path
  cas_required = false
}

resource "vault_kubernetes_auth_backend_role" "vault_kubernetes_auth_backend_role" {
  count                            = var.create_rbac == true ? 1 : 0
  backend                          = vault_mount.vault_mount.path
  role_name                        = "${var.namespace}-${var.workload_name}-role"
  bound_service_account_names      = var.service_account_name == null ? [var.workload_name] : [var.service_account_name]
  bound_service_account_namespaces = [var.namespace]
  token_policies                   = [vault_policy.vault_policy[0].name]
}

resource "vault_policy" "vault_policy" {
  count    = var.create_rbac == true ? 1 : 0
  name     = "${var.namespace}-${var.workload_name}-policy"
  policy   = "path \"${var.namespace}/${var.workload_name}/data\" {\n\tcapabilities = [\"${var.permissions}\"]\n}\n"
  provider = vault.rbom
}
