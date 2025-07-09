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

resource "vault_pki_secret_backend_cert" "certificate" {
  backend = var.pki_backend_path
  name    = var.role_name

  common_name = var.common_name
  alt_names   = var.alt_names
  other_sans  = var.other_sans

  ttl                   = var.ttl
  format                = var.format
  private_key_format    = var.private_key_format
  min_seconds_remaining = var.min_seconds_remaining
  auto_renew            = var.auto_renew
}
