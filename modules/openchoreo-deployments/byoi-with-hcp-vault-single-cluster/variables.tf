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
  default     = null
  sensitive   = true

  validation {
    condition     = var.google_webhook_address == null || length(trimspace(var.google_webhook_address)) > 0
    error_message = "If set, google_webhook_address must not be an empty or whitespace-only string."
  }
}

variable "docker_registry_host" {
  description = "The Docker registry host for pulling/pushing images."
  type        = string
}

variable "docker_registry_username" {
  description = "The Docker registry username for pulling images."
  type        = string
  sensitive   = true
}

variable "docker_registry_password" {
  description = "The Docker registry password for pulling images."
  type        = string
  sensitive   = true
}

variable "thunder_db_user_password_version" {
  description = "The version identifier for the ThunderDB user password, used to trigger password rotation."
  type        = string
  default     = "1"
}

variable "thunder_db_user_name" {
  description = "The username for the ThunderDB PostgreSQL user."
  type        = string
  default     = "thunder_db_user"
}

variable "thunder_db_type" {
  description = "Type of the Thunder DB. When set to \"postgres\" PostgreSQL resources will be created."
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres", "mysql", "mssql", "sqlite", "none"], var.thunder_db_type)
    error_message = "thunder_db_type must be one of: \"postgres\", \"mysql\", \"mssql\", \"sqlite\", or \"none\"."
  }
}
