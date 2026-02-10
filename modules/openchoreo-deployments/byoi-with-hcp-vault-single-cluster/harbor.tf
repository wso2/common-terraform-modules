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
  is_harbor = var.container_registry_type == "harbor"
}

resource "random_password" "openchoreo_cr_system_user_password" {
  count   = local.is_harbor ? 1 : 0
  length  = 12
  special = false
}

resource "harbor_project" "openchoreo" {
  count                = local.is_harbor ? 1 : 0
  name                 = "openchoreo"
  auto_sbom_generation = true
}

resource "harbor_robot_account" "openchoreo_system_user" {
  count       = local.is_harbor ? 1 : 0
  name        = "openchoreo-system-user"
  description = "Robot account for OpenChoreo to pull/push images from/to Harbor registry"
  level       = "project"
  secret      = random_password.openchoreo_cr_system_user_password[0].result
  permissions {
    access {
      action   = "pull"
      resource = "repository"
    }
    access {
      action   = "push"
      resource = "repository"
    }
    kind      = "project"
    namespace = harbor_project.openchoreo[0].name
  }
}
