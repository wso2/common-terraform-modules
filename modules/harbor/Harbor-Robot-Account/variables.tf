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

variable "robot_name" {
  description = "Name of the robot account"
  type        = string
}

variable "description" {
  description = "Description of the robot account"
  type        = string
  default     = null
}

variable "level" {
  description = "Level of the robot account: \"system\" or \"project\""
  type        = string
  default     = "project"

  validation {
    condition     = contains(["system", "project"], var.level)
    error_message = "level must be one of: \"system\" or \"project\"."
  }
}

variable "duration" {
  description = "Validity of the robot account in days. -1 never expires."
  type        = number
  default     = -1
}

variable "secret" {
  description = "Secret for the robot account. Null lets Harbor generate one (exposed via the secret output)."
  type        = string
  sensitive   = true
  default     = null
}

variable "permissions" {
  description = "Permissions of the robot account. For a project-level robot use one entry with kind \"project\" and the project name as namespace."
  type = list(object({
    kind      = string
    namespace = string
    access = list(object({
      action   = string
      resource = string
      effect   = optional(string)
    }))
  }))
}
