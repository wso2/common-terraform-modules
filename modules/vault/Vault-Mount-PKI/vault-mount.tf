# ---------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com).
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# ---------------------------------------------------------------------------------

resource "vault_mount" "vault_mount" {
  path        = var.path
  type        = "pki"
  description = "PKI artifacts of ${var.path}"

  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_config_ca" "certificate_issuer" {
  backend    = vault_mount.vault_mount.path
  pem_bundle = var.certificate_issuer_pem_bundle

  depends_on = [vault_mount.vault_mount]
}
