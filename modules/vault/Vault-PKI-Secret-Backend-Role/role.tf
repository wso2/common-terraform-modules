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

resource "vault_pki_secret_backend_role" "role" {
  backend                     = var.pki_backend_path
  name                        = var.name
  issuer_ref                  = var.issuer_ref
  ttl                         = var.ttl
  max_ttl                     = var.max_ttl
  allow_localhost             = var.allow_localhost
  allow_bare_domains          = var.allow_bare_domains
  allow_subdomains            = var.allow_subdomains
  allow_glob_domains          = var.allow_glob_domains
  allow_any_name              = var.allow_any_name
  allow_ip_sans               = var.allow_ip_sans
  allow_wildcard_certificates = var.allow_wildcard_certificates
  allowed_domains             = var.allowed_domains
  allowed_other_sans          = var.allowed_other_sans
  server_flag                 = var.server_flag
  client_flag                 = var.client_flag
  key_type                    = var.key_type
  key_bits                    = var.key_bits
  key_usage                   = var.key_usage
  ou                          = var.default_org_units
  organization                = var.default_organizations
  country                     = var.default_countries
  locality                    = var.default_localities
  province                    = var.default_provinces
  street_address              = var.default_street_addresses
  no_store                    = var.no_store
}
