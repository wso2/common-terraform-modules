# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "backend" {
  description = "The path where the kubernetes auth backend is mounted (e.g. the backend_path output of the Kubernetes-Auth module)"
  type        = string
  default     = "kubernetes"
}

variable "role_name" {
  description = "Name of the kubernetes auth role"
  type        = string
}

variable "bound_service_account_names" {
  description = "List of ServiceAccount names allowed to log in with this role"
  type        = list(string)
}

variable "bound_service_account_namespaces" {
  description = "List of namespaces the bound ServiceAccounts must belong to"
  type        = list(string)
}

variable "token_policies" {
  description = "List of policies to encode onto generated tokens"
  type        = list(string)
}

variable "token_type" {
  description = "The type of token that should be generated"
  type        = string
  default     = "default"
}

variable "token_ttl" {
  description = "The incremental lifetime for generated tokens in number of seconds"
  type        = number
}

variable "token_max_ttl" {
  description = "The maximum lifetime for generated tokens in number of seconds"
  type        = number
}

variable "audience" {
  description = "Optional audience claim to require on the presented ServiceAccount JWTs (recommended when using projected tokens with a dedicated audience)"
  type        = string
  default     = null
}
