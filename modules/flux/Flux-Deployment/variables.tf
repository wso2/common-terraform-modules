# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "path" {
  description = "The path to the git repository where flux will be bootstrapped."
  type        = string
}
variable "image_pull_secret" {
  description = "The name of the image pull secret to use for the flux deployment."
  type        = string
  default     = null
}
