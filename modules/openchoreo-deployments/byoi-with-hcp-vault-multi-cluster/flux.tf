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


module "oc-cp-fluxcd" {
  source = "../../flux/Flux-Deployment"
  path   = var.oc_cp_flux_kustomization_path
  providers = {
    flux = flux.oc_cp
  }
}

module "oc-dp-fluxcd" {
  source = "../../flux/Flux-Deployment"
  path   = var.oc_dp_flux_kustomization_path
  providers = {
    flux = flux.oc_dp
  }
}

module "oc-ci-fluxcd" {
  source = "../../flux/Flux-Deployment"
  path   = var.oc_ci_flux_kustomization_path
  providers = {
    flux = flux.oc_ci
  }
}

module "oc-ob-fluxcd" {
  source = "../../flux/Flux-Deployment"
  path   = var.oc_ob_flux_kustomization_path
  providers = {
    flux = flux.oc_ob
  }
}
