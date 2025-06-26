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

variable "login_name" {
  description = "The name of the SQL login to create."
  type        = string
}
variable "password" {
  description = "The password for the SQL login."
  type        = string
  sensitive   = true
}
variable "change_password_on_login" {
  description = "Whether the SQL login must change password on first login."
  type        = bool
  default     = false
}
variable "database_id" {
  description = "The ID of the database to set as default for the SQL login."
  type        = string
}
variable "default_language" {
  description = "The default language for the SQL login."
  type        = string
  default     = "english"
}
variable "check_password_expiration" {
  description = "Whether to check password expiration for the SQL login."
  type        = bool
  default     = false
}
variable "check_password_policy" {
  description = "Whether to enforce password policy for the SQL login."
  type        = bool
  default     = false
}
