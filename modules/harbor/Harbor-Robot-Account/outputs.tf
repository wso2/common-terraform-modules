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

output "full_name" {
  description = "Full name of the robot account as used for authentication (e.g. robot$<project>+<name>)"
  value       = harbor_robot_account.robot_account.full_name
}

output "robot_id" {
  description = "ID of the robot account"
  value       = harbor_robot_account.robot_account.robot_id
}

output "secret" {
  description = "Secret of the robot account"
  value       = harbor_robot_account.robot_account.secret
  sensitive   = true
}
