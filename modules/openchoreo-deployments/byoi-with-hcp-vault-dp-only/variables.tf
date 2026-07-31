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

# --- Flux ---
variable "flux_kustomization_path" {
  description = "Git path Flux bootstraps + syncs the oc-dp manifests from."
  type        = string
}

variable "image_pull_secret" {
  description = "Optional image pull secret for the Flux controllers."
  type        = string
  default     = ""
}

# --- external-secrets (login to the EXISTING/restored Vault) ---
variable "external_secrets_namespace" {
  description = "Namespace the external-secrets approle-creds secrets are created in."
  type        = string
  default     = "external-secrets"
}

variable "approle_backend" {
  description = "Vault AppRole auth backend path (must already exist in the restored Vault)."
  type        = string
  default     = "dp-approle"
}

variable "external_secrets_read_role_name" {
  description = "Existing AppRole role name for external-secrets read access."
  type        = string
  default     = "dp-external-secrets-read"
}

variable "external_secrets_write_role_name" {
  description = "Existing AppRole role name for external-secrets write access."
  type        = string
  default     = "dp-external-secrets-write"
}

variable "external_secrets_application_read_role_name" {
  description = "Existing AppRole role name for application-secrets read access."
  type        = string
  default     = "cloud-dp-application-secrets-read"
}
