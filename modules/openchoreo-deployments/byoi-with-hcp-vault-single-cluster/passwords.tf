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

resource "random_password" "backstage_admin_password" {
  length  = 16
  special = false
}

resource "random_id" "backstage_client_id" {
  byte_length = 12
}

resource "random_password" "backstage_client_secret" {
  length  = 24
  special = false
}

resource "random_id" "customer_portal_client_id" {
  byte_length = 12
}

resource "random_password" "customer_portal_client_secret" {
  length  = 24
  special = false
}

resource "random_id" "rca_agent_client_id" {
  byte_length = 12
}

resource "random_password" "rca_agent_client_secret" {
  length  = 24
  special = false
}

resource "random_id" "system_app_client_id" {
  byte_length = 12
}

resource "random_password" "system_app_client_secret" {
  length  = 24
  special = false
}

resource "random_id" "service_mcp_client_id" {
  byte_length = 12
}

resource "random_password" "service_mcp_client_secret" {
  length  = 24
  special = false
}

resource "random_id" "oc_observer_client_id" {
  byte_length = 12
}

resource "random_password" "oc_observer_client_secret" {
  length  = 24
  special = false
}

resource "random_password" "backstage_backend_secret" {
  length  = 32
  special = false
}

resource "random_password" "opensearch_password" {
  length  = 32
  special = false
}
