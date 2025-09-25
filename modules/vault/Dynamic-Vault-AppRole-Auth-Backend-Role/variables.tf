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

variable "role_name" {
  description = "Name of the App Role"
  type        = string
}

variable "token_policies" {
  description = "List of policies to encode onto generated tokens"
  type        = list(string)
}

variable "bind_secret_id" {
  description = "Whether or not to require secret_id to be presented when logging in using this AppRole"
  type        = bool
  default     = true
}

variable "secret_id_ttl" {
  description = "The number of seconds after which any SecretID expires"
  type        = number
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

variable "secret_id_num_uses" {
  description = "The number of seconds after which any SecretID expires"
  type        = number
}

variable "vault_auth_backend_max_lease_ttl" {
  type        = string
  default     = "43800h"
  description = "Global max lease TTL for the Hashicorp vault auth backend"
}

variable "vault_auth_backend_default_lease_ttl" {
  type        = string
  default     = "43800h"
  description = "Global default lease TTL for the Hashicorp vault auth backend"
}

variable "secret_id_1_rotation_time_in_months" {
  type = number
  default = 61
}

variable "secret_id_2_rotation_time_in_months" {
  type = number
  default = 47
}
