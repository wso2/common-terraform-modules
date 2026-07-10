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

variable "oc_dp_flux_kustomization_path" {
  description = "The path to the Flux Kustomization for the OC DP cluster."
  type        = string
}

variable "oc_ci_flux_kustomization_path" {
  description = "The path to the Flux Kustomization for the OC CI cluster."
  type        = string
}

variable "oc_ob_flux_kustomization_path" {
  description = "The path to the Flux Kustomization for the OC OB cluster."
  type        = string
}

variable "google_webhook_address" {
  description = "The address of the Google webhook for flux alerts"
  type        = string
  sensitive   = true
}

variable "docker_registry_host" {
  description = "The Docker registry host for pulling/pushing images."
  type        = string
}

variable "docker_registry_username" {
  description = "The Docker registry username for pulling images."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.docker_registry_username)) > 0
    error_message = "docker_registry_username must not be empty."
  }
}

variable "docker_registry_password" {
  description = "The Docker registry password for pulling images."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.docker_registry_password)) > 0
    error_message = "docker_registry_password must not be empty."
  }
}

variable "oc_system_db_type" {
  description = "Type of the OC system DB. When set to \"postgres\" PostgreSQL resources will be created."
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres", "mysql", "mssql", "sqlite", "none"], var.oc_system_db_type)
    error_message = "oc_system_db_type must be one of: \"postgres\", \"mysql\", \"mssql\", \"sqlite\", or \"none\"."
  }
}

variable "secret_store_type" {
  description = "Type of the secret store. When set to \"vault\" Vault resources will be created."
  type        = string
  default     = "vault"

  validation {
    condition     = contains(["vault", "none"], var.secret_store_type)
    error_message = "secret_store_type must be one of: \"vault\" or \"none\"."
  }
}

variable "secrets_mount_path" {
  description = "The mount path in Vault where secrets will be stored."
  type        = string
  default     = "secrets"
}

variable "external_secrets_vault_read_policy_name" {
  description = "The name of the Vault policy for External Secrets read access."
  type        = string
  default     = "external-secrets-default-read-policy"
}

variable "external_secrets_vault_write_policy_name" {
  description = "The name of the Vault policy for External Secrets write access."
  type        = string
  default     = "external-secrets-automation-write-policy"
}

variable "external_secrets_read_role_name" {
  description = "The name of the Vault AppRole for External Secrets read access."
  type        = string
  default     = "external-secrets-read"
}

variable "external_secrets_write_role_name" {
  description = "The name of the Vault AppRole for External Secrets write access."
  type        = string
  default     = "external-secrets-write"
}

variable "opensearch_username" {
  description = "The username for authenticating to the OpenSearch cluster."
  type        = string
  default     = "admin"
}

variable "oc_system_db_system_username" {
  description = "The username for the OpenChoreo System database user."
  type        = string
  default     = "oc_system_db_user"
}

variable "prefix_vault_resources" {
  description = "Custom prefix for Vault resources (e.g., policies, roles). Useful for distinguishing resources when using a shared Vault instance."
  type        = string
  default     = ""
}

variable "oc_observer_client_id" {
  description = "Client ID for the oc observer IdP client."
  type        = string
}

variable "oc_observer_client_secret" {
  description = "Client secret for the oc observer IdP client."
  type        = string
  sensitive   = true
}

variable "workload_publisher_client_id" {
  description = "Client ID for the workload publisher IdP client."
  type        = string
}

variable "workload_publisher_client_secret" {
  description = "Client secret for the workload publisher IdP client."
  type        = string
  sensitive   = true
}

variable "backstage_client_id" {
  description = "Client ID for the backstage IdP client."
  type        = string
}


variable "rca_agent_client_id" {
  description = "Client ID for the rca agent IdP client."
  type        = string
}


variable "service_mcp_client_id" {
  description = "Client ID for the service mcp IdP client."
  type        = string
}

variable "system_app_client_id" {
  description = "Client ID for the system app IdP client."
  type        = string
}

variable "system_app_client_secret" {
  description = "Client secret for the system app IdP client."
  type        = string
  sensitive   = true
}
