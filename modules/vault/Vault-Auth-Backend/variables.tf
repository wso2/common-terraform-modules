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

variable "type" {
  type        = string
  description = "The type of the auth backend (e.g., 'userpass', 'ldap', 'jwt', etc.)"
}

variable "max_lease_ttl" {
  type        = string
  default     = "43800h"
  description = "Global max lease TTL for the Hashicorp vault auth backend"
}

variable "default_lease_ttl" {
  type        = string
  default     = "43800h"
  description = "Global default lease TTL for the Hashicorp vault auth backend"
}
