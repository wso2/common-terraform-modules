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

locals {
  # 1. Group all CI/CD variables into a list to check them easily
  cicd_vars = [
    var.github_cicd_webhook_secret,
    var.cicd_github_app_id,
    var.cicd_github_app_installation_id,
    var.cicd_github_app_private_key,
    var.cicd_github_app_client_id,
    var.cicd_ecr_access_key_id,
    var.cicd_ecr_secret_access_key,
    var.cicd_ecr_region
  ]

  # 2. Evaluate if ALL of them have a valid value
  include_cicd = alltrue([for v in local.cicd_vars : (v != null && v != "")])

  # 3. Define the base secrets that are always present
  base_secrets = {
    backstage-admin-username           = join("-", [var.environment, var.backstage_admin_username])
    backstage-admin-password           = random_password.backstage_admin_password.result
    backstage-client-id                = random_id.backstage_client_id.hex
    backstage-client-secret            = random_password.backstage_client_secret.result
    customer-portal-client-id          = random_id.customer_portal_client_id.hex
    customer-portal-client-secret      = random_password.customer_portal_client_secret.result
    rca-agent-client-id                = random_id.rca_agent_client_id.hex
    rca-agent-client-secret            = random_password.rca_agent_client_secret.result
    system-app-client-id               = random_id.system_app_client_id.hex
    system-app-client-secret           = random_password.system_app_client_secret.result
    service-mcp-client-id              = random_id.service_mcp_client_id.hex
    service-mcp-client-secret          = random_password.service_mcp_client_secret.result
    oc-observer-client-id              = random_id.oc_observer_client_id.hex
    oc-observer-client-secret          = random_password.oc_observer_client_secret.result
    workload-publisher-client-id       = random_id.workload_publisher_client_id.hex
    workload-publisher-client-secret   = random_password.workload_publisher_client_secret.result
    backstage-backend-secret           = random_password.backstage_backend_secret.result
    jenkins-api-key                    = "unused"
    oc-system-db-postgres-host         = var.oc_system_db_postgres_host
    oc-system-db-postgres-port         = var.oc_system_db_postgres_port
    oc-system-db-postgres-user         = var.oc_system_db_system_username
    oc-system-db-postgres-password     = random_password.oc_system_db_password[0].result
    oc-system-db-backstage-postgres-db = "backstage"
    opensearch-password                = random_password.opensearch_password.result
    opensearch-username                = var.opensearch_username
    dockerconfigjson = jsonencode(
      {
        auths = {
          (var.docker_registry_host) = {
            username = local.registry_username
            password = local.registry_password
            auth     = local.registry_auth
          }
        }
      }
    )
  }

  # 4. Define the CI/CD block structure
  cicd_block = {
    cicd = {
      webhook-secret             = var.github_cicd_webhook_secret
      github-app-id              = var.cicd_github_app_id
      github-app-installation-id = var.cicd_github_app_installation_id
      github-app-private-key     = var.cicd_github_app_private_key
      github-app-client-id       = var.cicd_github_app_client_id
      container-registry = {
        ecr = {
          access-key-id     = var.cicd_ecr_access_key_id
          secret-access-key = var.cicd_ecr_secret_access_key
          region            = var.cicd_ecr_region
        }
      }
    }
  }
}
