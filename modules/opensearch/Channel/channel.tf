# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

resource "opensearch_channel_configuration" "channel_configuration" {
  body = jsonencode({
    config_id = var.channel-configuration.id
    config = {
      name        = var.channel-configuration.name
      description = var.channel-configuration.description
      config_type = "webhook"
      is_enabled  = var.channel-configuration.enabled
      webhook = {
        url = var.channel-configuration.webhook
      }
    }
  })
}

