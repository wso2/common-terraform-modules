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

variable "opensearch_cluster_url" {
  description = "Opensearch cluster URL"
  type        = string
  default     = ""
}

variable "opensearch_username" {
  description = "Opensearch cluster username"
  type        = string
  default     = ""
}

variable "opensearch_password" {
  description = "Opensearch cluster password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "channel_configuration" {
  type = object({
    id          = string
    name        = string
    description = string
    enabled     = bool
    webhook     = string
  })
  default = {
    id          = "config_1"
    name        = "channel-config-name"
    description = "Description for the channel"
    enabled     = true
    webhook     = "webhook url"
  }
}

