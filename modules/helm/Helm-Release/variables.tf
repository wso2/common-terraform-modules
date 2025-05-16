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

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
}
variable "chart_repo" {
  description = "Name of the Helm chart"
  type        = string
  default     = null
}
variable "chart_name" {
  description = "Name of the Helm chart"
  type        = string
}
variable "version_number" {
  description = "Version of the Helm chart"
  type        = string
  default     = null
}
variable "create_namespace" {
  description = "Create namespace if it does not exist"
  type        = bool
  default     = false
}
variable "disable_crd_hooks" {
  description = "Disable CRD hooks"
  type        = bool
  default     = false
}
variable "disable_openapi_validation" {
  description = "Disable OpenAPI validation"
  type        = bool
  default     = false
}
variable "disable_webhooks" {
  description = "Disable webhooks"
  type        = bool
  default     = false
}
variable "skip_crds" {
  description = "Skip CRDs"
  type        = bool
  default     = false
}
variable "values" {
  description = "Values for the Helm chart"
  type        = list(string)
}
variable "namespace" {
  description = "Namespace for the Helm release"
  type        = string
}
