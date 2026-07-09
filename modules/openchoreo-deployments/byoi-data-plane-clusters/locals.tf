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
  base_secrets = {
    backstage-admin-username           = join("-", [var.environment, var.backstage_admin_username])
    backstage-admin-password           = random_password.backstage_admin_password.result
    backstage-client-id                = coalesce(var.backstage_client_id, random_id.backstage_client_id.hex)
    backstage-client-secret            = coalesce(var.backstage_client_secret, random_password.backstage_client_secret.result)
    customer-portal-client-id          = random_id.customer_portal_client_id.hex
    customer-portal-client-secret      = random_password.customer_portal_client_secret.result
    rca-agent-client-id                = coalesce(var.rca_agent_client_id, random_id.rca_agent_client_id.hex)
    rca-agent-client-secret            = coalesce(var.rca_agent_client_secret, random_password.rca_agent_client_secret.result)
    system-app-client-id               = random_id.system_app_client_id.hex
    system-app-client-secret           = random_password.system_app_client_secret.result
    service-mcp-client-id              = coalesce(var.service_mcp_client_id, random_id.service_mcp_client_id.hex)
    service-mcp-client-secret          = coalesce(var.service_mcp_client_secret, random_password.service_mcp_client_secret.result)
    oc-observer-client-id              = coalesce(var.oc_observer_client_id, random_id.oc_observer_client_id.hex)
    oc-observer-client-secret          = coalesce(var.oc_observer_client_secret, random_password.oc_observer_client_secret.result)
    workload-publisher-client-id       = coalesce(var.workload_publisher_client_id, random_id.workload_publisher_client_id.hex)
    workload-publisher-client-secret   = coalesce(var.workload_publisher_client_secret, random_password.workload_publisher_client_secret.result)
    backstage-backend-secret           = random_password.backstage_backend_secret.result
    jenkins-api-key                    = "unused"
    oc-system-db-postgres-host         = var.oc_system_db_postgres_host
    oc-system-db-postgres-port         = var.oc_system_db_postgres_port
    oc-system-db-postgres-user         = var.oc_system_db_system_username
    oc-system-db-postgres-password     = random_password.oc_system_db_password[0].result
    oc-system-db-backstage-postgres-db = "backstage"
    opensearch-password                = random_password.opensearch_password.result
    opensearch-username                = var.opensearch_username
    google-webhook-address             = var.google_webhook_address
    dockerconfigjson = jsonencode(
      {
        auths = {
          (var.docker_registry_host) = {
            username = var.docker_registry_username
            password = var.docker_registry_password
            auth     = local.registry_auth
          }
        }
      }
    )
  }
}
