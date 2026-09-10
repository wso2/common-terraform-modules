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

# Single data-plane cluster connecting to an existing OpenChoreo control plane.
# Uses the caller's default kubernetes/flux/vault providers (all pointed at the one
# oc-dp cluster + its restored Vault).
terraform {
  required_version = ">= 1.10"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 5.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 3.0.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.5.1"
    }
  }
}
