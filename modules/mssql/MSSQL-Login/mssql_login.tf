# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (https://www.wso2.com) All Rights Reserved.
#
# WSO2 LLC. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------------------------------

resource "mssql_sql_login" "sql_login" {
  name                      = var.login_name
  password                  = var.password
  must_change_password      = var.change_password_on_login
  default_database_id       = var.database_id
  default_language          = var.default_language
  check_password_expiration = var.check_password_expiration
  check_password_policy     = var.check_password_policy
}
