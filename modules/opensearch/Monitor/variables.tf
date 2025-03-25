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

variable "opensearch_cluster_url" {
  description = "Opensearch cluster URL"
  type        = string
  default     = ""
}

variable "opensearch_username" {
  description = "Opensearch cluster username"
  type        = string
  default     = ""
}

variable "opensearch_password" {
  description = "Opensearch cluster password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "monitor_configuration" {
  type = object({
    type         = string
    name         = string
    monitor_type = string
    enabled      = bool
  })
}

variable "monitor_schedule" {
  type = object({
    interval = number
    unit     = string
  })
  default = {
    interval = 1
    unit     = "MINUTES"
  }
}

variable "monitor_query_search_range" {
  type = object({
    from = string
    to   = string
  })
  default = {
    from = "{{period_end}}||-10m"
    to   = "{{period_end}}"
  }
}

variable "log_search_namespace" {
  type        = string
  description = "The namespace where the log is searching"
}

variable "log_search_container" {
  type        = string
  description = "The container where the log is searching"
}

variable "log_search_phrase" {
  type        = string
  description = "The log search phrase"
  default     = "*<SEARCH_PHRASE>*"
}

variable "log_aggregation_fixed_interval" {
  type        = string
  description = "Aggregation fixed interval. Y window"
  default     = "<Y>m"
}

variable "log_aggregation_min_doc_count" {
  type        = number
  description = "Log aggregation min doc count"
}

variable "trigger_config_name" {
  type        = string
  description = "Name of the trigger configurations"
}

variable "trigger_config_script" {
  type = object({
    source = string
    lang   = string
  })
  default = {
    source = "params.log_count \u003e 2"
    lang   = "painless"
  }
}

variable "monitor_action_trigger" {
  type = object({
    name           = string
    destination_id = string
  })
}

