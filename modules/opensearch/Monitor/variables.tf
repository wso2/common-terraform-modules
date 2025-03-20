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

variable "opensearch-cluster-url" {
  description = "Opensearch cluster URL"
  type        = string
  default     = ""
}

variable "opensearch-username" {
  description = "Opensearch cluster username"
  type        = string
  default     = ""
}

variable "opensearch-password" {
  description = "Opensearch cluster password"
  type        = string
  default     = ""
}

variable "channel-configuration" {
  type = object({
    id          = string
    name        = string
    description = string
    enabled     = bool
    webhook     = string
  })
  default = {
    id          = "config_1"
    name        = "channel-config-name"
    description = "Description for the channel"
    enabled     = true
    webhook     = "webhook url"
  }
}

variable "monitor-configuration" {
  type = object({
    type = string
    name = string
    monitor_type = string
    enabled = bool
  })
}

variable "monitor-schedule" {
  type = object({
    interval = number
    unit = string
  })
  default = {
    interval = 1
    unit = "MINUTES"
  }
}

variable "monitor-query-search-range" {
  type = object({
    from = string
    to = string
  })
  default = {
    from = "{{period_end}}||-10m"
    to = "{{period_end}}"
  }
}

variable "log-search-namespace" {
  type = string
  description = "The namespace where the log is searching"
}

variable "log-search-container" {
  type = string
  description = "The container where the log is searching"
}

variable "log-search-phrase" {
  type = string
  description = "The log search phrase"
  default = "*<SEARCH_PHRASE>*"
}

variable "log-aggregation-fixed-interval" {
  type = string
  description = "Aggregation fixed interval. Y window"
  default = "<Y>m"
}

variable "log-aggregation-min-doc-count" {
  type = number
  description = "Log aggregation min doc count"
}

variable "trigger-config-name" {
  type = string
  description = "Name of the trigger configurations"
}

variable "trigger-config-script" {
  type = object({
    source = string
    lang = string
  })
  default = {
    source = "params.log_count \u003e 2"
    lang = "painless"
  }
}

variable "monitor-action-trigger" {
  type = object({
    name = string
    destination_id = string
  })
}

