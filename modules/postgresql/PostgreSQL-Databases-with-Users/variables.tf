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

variable "databases" {
  description = "Map of databases and the users who have permissions on them"
  type = map(object({
    read_only_users  = list(string)
    read_write_users = list(string)
  }))
  default = {
    primary_db = {
      read_only_users  = ["data_analyst"]
      read_write_users = ["app_backend"]
    }
    reporting_db = {
      read_only_users  = ["data_analyst", "app_backend"]
      read_write_users = []
    }
  }
}

variable "db_owner_role_name" {
  description = "The name of the role that will own all the databases."
  type        = string
}
