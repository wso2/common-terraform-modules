# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

# ignore_changes = all: the key is fixed after the first apply and NEVER regenerated.
# Regenerating this key makes all previously-encrypted data permanently undecryptable.
resource "random_bytes" "key" {
  length = var.byte_length

  lifecycle {
    ignore_changes = all
  }
}
