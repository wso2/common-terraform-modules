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
    opensearch-password    = random_password.opensearch_password.result
    opensearch-username    = var.opensearch_username
    google-webhook-address = var.google_webhook_address

    backstage-client-id              = var.backstage_client_id
    rca-agent-client-id              = var.rca_agent_client_id
    service-mcp-client-id            = var.service_mcp_client_id
    oc-observer-client-id            = var.oc_observer_client_id
    oc-observer-client-secret        = var.oc_observer_client_secret
    workload-publisher-client-id     = var.workload_publisher_client_id
    workload-publisher-client-secret = var.workload_publisher_client_secret
    system-app-client-id             = var.system_app_client_id
    system-app-client-secret         = var.system_app_client_secret

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
