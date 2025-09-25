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

output "role_id" {
  value = vault_approle_auth_backend_role.app_role.role_id
}

output "secret_id" {
  value = time_rotating.secret_id_1.unix > time_rotating.secret_id_2.unix ? vault_approle_auth_backend_role_secret_id.secret_id_1.secret_id : vault_approle_auth_backend_role_secret_id.secret_id_2.secret_id
}
