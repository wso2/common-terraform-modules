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

variable "flux_kustomization_path" {
  description = "The path to the flux kustomization manifests."
  type        = string
}

variable "google_webhook_address" {
  description = "The address of the Google webhook for flux alerts"
  type        = string
  sensitive   = true
}
