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
# --------------------------------------------------------------------------------------

resource "helm_release" "release" {
  name                       = var.release_name
  repository                 = var.chart_repo
  chart                      = var.chart_name
  version                    = var.version_number
  create_namespace           = var.create_namespace
  disable_crd_hooks          = var.disable_crd_hooks
  disable_openapi_validation = var.disable_openapi_validation
  disable_webhooks           = var.disable_webhooks
  values                     = var.values
  skip_crds                  = var.skip_crds
  namespace                  = var.namespace
  upgrade_install            = var.upgrade_install
  wait                       = var.wait_until_resources
}
