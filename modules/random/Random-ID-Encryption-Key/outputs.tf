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

output "hex" {
  description = "The generated key as a lowercase hex string (64 chars for the default 32-byte length)."
  value       = random_id.key.hex
  sensitive   = true
}

output "b64_std" {
  description = "The generated key as a standard base64-encoded string."
  value       = random_id.key.b64_std
  sensitive   = true
}

output "b64_url" {
  description = "The generated key as a URL-safe base64-encoded string."
  value       = random_id.key.b64_url
  sensitive   = true
}
