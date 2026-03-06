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

module "oc-cp-kubernetes-namespaces" {
  count  = local.is_vault ? 1 : 0
  source = "../../kubernetes/Namespaces"
  kubernetes_namespaces = {
    external-secrets = {}
  }
  providers = {
    kubernetes = kubernetes.oc_cp
  }
}

module "oc-cp-kubernetes-secrets-external-secrets" {
  count     = local.is_vault ? 1 : 0
  source    = "../../kubernetes/Secrets"
  namespace = "external-secrets"
  secrets = {
    approle-creds-read-permission = {
      data = {
        role_id   = module.external-secrets-read-app-role[0].role_id
        secret_id = module.external-secrets-read-app-role[0].secret_id
      }
    }
    approle-creds-write-permission = {
      data = {
        role_id   = module.external-secrets-write-app-role[0].role_id
        secret_id = module.external-secrets-write-app-role[0].secret_id
      }
    }
  }
  depends_on = [
    module.oc-cp-kubernetes-namespaces,
    module.external-secrets-read-app-role,
    module.external-secrets-write-app-role
  ]
  providers = {
    kubernetes = kubernetes.oc_cp
  }
}

module "oc-cp-kubernetes-secrets-flux-system" {
  source    = "../../kubernetes/Secrets"
  count     = var.google_webhook_address == null || length(trimspace(var.google_webhook_address)) == 0 ? 0 : 1
  namespace = "flux-system"
  secrets = {
    google-webhook = {
      data = {
        address = var.google_webhook_address
      }
    }
  }
  depends_on = [
    module.oc-cp-fluxcd
  ]
  providers = {
    kubernetes = kubernetes.oc_cp
  }
}

module "oc-dp-kubernetes-namespaces" {
  count  = local.is_vault ? 1 : 0
  source = "../../kubernetes/Namespaces"
  kubernetes_namespaces = {
    external-secrets = {}
  }
  providers = {
    kubernetes = kubernetes.oc_dp
  }
}

module "oc-dp-kubernetes-secrets-external-secrets" {
  count     = local.is_vault ? 1 : 0
  source    = "../../kubernetes/Secrets"
  namespace = "external-secrets"
  secrets = {
    approle-creds-read-permission = {
      data = {
        secret_id = module.external-secrets-read-app-role[0].secret_id
      }
    }
    approle-creds-write-permission = {
      data = {
        role_id   = module.external-secrets-write-app-role[0].role_id
        secret_id = module.external-secrets-write-app-role[0].secret_id
      }
    }
  }
  depends_on = [
    module.oc-dp-kubernetes-namespaces,
    module.external-secrets-read-app-role,
    module.external-secrets-write-app-role
  ]
  providers = {
    kubernetes = kubernetes.oc_dp
  }
}

module "oc-dp-kubernetes-secrets-flux-system" {
  source    = "../../kubernetes/Secrets"
  count     = var.google_webhook_address == null || length(trimspace(var.google_webhook_address)) == 0 ? 0 : 1
  namespace = "flux-system"
  secrets = {
    google-webhook = {
      data = {
        address = var.google_webhook_address
      }
    }
  }
  depends_on = [
    module.oc-dp-fluxcd
  ]
  providers = {
    kubernetes = kubernetes.oc_dp
  }
}


module "oc-ci-kubernetes-namespaces" {
  count  = local.is_vault ? 1 : 0
  source = "../../kubernetes/Namespaces"
  kubernetes_namespaces = {
    external-secrets = {}
  }
  providers = {
    kubernetes = kubernetes.oc_ci
  }
}

module "oc-ci-kubernetes-secrets-external-secrets" {
  count     = local.is_vault ? 1 : 0
  source    = "../../kubernetes/Secrets"
  namespace = "external-secrets"
  secrets = {
    approle-creds-read-permission = {
      data = {
        secret_id = module.external-secrets-read-app-role[0].secret_id
      }
    }
    approle-creds-write-permission = {
      data = {
        role_id   = module.external-secrets-write-app-role[0].role_id
        secret_id = module.external-secrets-write-app-role[0].secret_id
      }
    }
  }
  depends_on = [
    module.oc-ci-kubernetes-namespaces,
    module.external-secrets-read-app-role,
    module.external-secrets-write-app-role
  ]
  providers = {
    kubernetes = kubernetes.oc_ci
  }
}

module "oc-ci-kubernetes-secrets-flux-system" {
  source    = "../../kubernetes/Secrets"
  count     = var.google_webhook_address == null || length(trimspace(var.google_webhook_address)) == 0 ? 0 : 1
  namespace = "flux-system"
  secrets = {
    google-webhook = {
      data = {
        address = var.google_webhook_address
      }
    }
  }
  depends_on = [
    module.oc-ci-fluxcd
  ]
  providers = {
    kubernetes = kubernetes.oc_ci
  }
}

module "oc-ob-kubernetes-namespaces" {
  count  = local.is_vault ? 1 : 0
  source = "../../kubernetes/Namespaces"
  kubernetes_namespaces = {
    external-secrets = {}
  }
  providers = {
    kubernetes = kubernetes.oc_ob
  }
}

module "oc-ob-kubernetes-secrets-external-secrets" {
  count     = local.is_vault ? 1 : 0
  source    = "../../kubernetes/Secrets"
  namespace = "external-secrets"
  secrets = {
    approle-creds-read-permission = {
      data = {
        secret_id = module.external-secrets-read-app-role[0].secret_id
      }
    }
    approle-creds-write-permission = {
      data = {
        role_id   = module.external-secrets-write-app-role[0].role_id
        secret_id = module.external-secrets-write-app-role[0].secret_id
      }
    }
  }
  depends_on = [
    module.oc-ob-kubernetes-namespaces,
    module.external-secrets-read-app-role,
    module.external-secrets-write-app-role
  ]
  providers = {
    kubernetes = kubernetes.oc_ob
  }
}

module "oc-ob-kubernetes-secrets-flux-system" {
  source    = "../../kubernetes/Secrets"
  count     = var.google_webhook_address == null || length(trimspace(var.google_webhook_address)) == 0 ? 0 : 1
  namespace = "flux-system"
  secrets = {
    google-webhook = {
      data = {
        address = var.google_webhook_address
      }
    }
  }
  depends_on = [
    module.oc-ob-fluxcd
  ]
  providers = {
    kubernetes = kubernetes.oc_ob
  }
}


