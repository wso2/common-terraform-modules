# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "project_name" {
  description = "Name of the Harbor project"
  type        = string
}

variable "public" {
  description = "Whether the project repositories are publicly accessible"
  type        = bool
  default     = false
}

variable "vulnerability_scanning" {
  description = "Automatically scan images on push"
  type        = bool
  default     = true
}

variable "auto_sbom_generation" {
  description = "Automatically generate an SBOM on push"
  type        = bool
  default     = false
}
