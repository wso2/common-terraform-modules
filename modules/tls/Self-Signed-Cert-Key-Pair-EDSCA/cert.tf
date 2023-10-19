# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "tls_private_key" "private_key" {
  algorithm   = "EDSCA"
  ecdsa_curve = var.private_key_edsca_curve
}

resource "tls_self_signed_cert" "self_signed_cert" {
  private_key_pem = tls_private_key.private_key.private_key_pem
  dynamic "subject" {
    for_each = var.subject != null ? [1] : []
    content {
      common_name         = var.subject.common_name
      organization        = var.subject.organization
      organizational_unit = var.subject.organizational_unit
      locality            = var.subject.locality
      province            = var.subject.province
      country             = var.subject.country
      postal_code         = var.subject.postal_code
      street_address      = var.subject.street_address
      serial_number       = var.subject.serial_number
    }
  }

  validity_period_hours = var.validity_period_hours
  early_renewal_hours   = var.early_renewal_hours

  allowed_uses = var.allowed_uses
  uris         = var.uris
  dns_names    = var.dns_names
}
