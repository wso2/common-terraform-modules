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


resource "opensearch_monitor" "pdp_monitor_1" {
  body = jsonencode({
    type         = var.monitor_configuration.type
    name         = var.monitor_configuration.name
    monitor_type = var.monitor_configuration.monitor_type
    enabled      = var.monitor_configuration.enabled
    schedule = {
      period = {
        interval = var.monitor_schedule.interval
        unit     = var.monitor_schedule.unit
      }
    }
    inputs = [
      {
        search = {
          indices = ["container-logs-*"]
          query = {
            size = 0
            query = {
              bool = {
                filter = [
                  {
                    range = {
                      "@timestamp" = {
                        from          = var.monitor_query_search_range.from
                        to            = var.monitor_query_search_range.to
                        include_lower = true
                        include_upper = true
                        format        = "epoch_millis"
                        boost         = 1
                      }
                    }
                  },
                  {
                    term = {
                      "kubernetes.namespace_name" = {
                        value = var.log_search_namespace
                      }
                    }
                  },
                  {
                    term = {
                      "kubernetes.container_name" = {
                        value = var.log_search_container
                        boost = 1
                      }
                    }
                  },
                  {
                    wildcard = {
                      log = {
                        wildcard = var.log_search_phrase
                        boost    = 1
                      }
                    }
                  }
                ]
                adjust_pure_negative = true
                boost                = 1
              }
            }
            aggregations = {
              by_time = {
                date_histogram = {
                  field          = "@timestamp"
                  format         = "epoch_millis"
                  fixed_interval = var.log_aggregation_fixed_interval
                  offset         = 0
                  order = {
                    "_key" = "asc"
                  }
                  keyed         = false
                  min_doc_count = var.log_aggregation_min_doc_count
                }
              }
            }
          }
        }
      }
    ]
    triggers = [
      {
        bucket_level_trigger = {
          name     = var.trigger_config_name
          severity = "1"
          condition = {
            buckets_path = {
              log_count = "_count"
            }
            parent_bucket_path = "number_of_matching_logs"
            script = {
              source = var.trigger_config_script.source
              lang   = var.trigger_config_script.lang
            }
          }
          actions = [
            {
              name           = var.monitor_action_trigger.name
              destination_id = var.monitor_action_trigger.destination_id
              message_template = {
                source = "{ \"monitorId\": \"{{ctx.monitor._id}}\", \"monitorName\": \"{{ctx.monitor.name}}\", \"monitorType\": \"{{ctx.monitor.type}}\", \"triggerName\": \"{{ctx.trigger.name}}\", \"triggerSeverity\": \"{{ctx.trigger.severity}}\", \"periodStart\": \"{{ctx.periodStart}}\", \"periodEnd\": \"{{ctx.periodEnd}}\",\"logCount\": \"{{ctx.results.0.hits.total.value}}\",\"type\": \"logs\"}"
                lang   = "mustache"
              }
              throttle_enabled = false
              subject_template = {
                source = "Alerting Notification action"
                lang   = "mustache"
              }
              action_execution_policy = {
                action_execution_scope = {
                  per_alert = {
                    actionable_alerts = [
                      "DEDUPED",
                      "NEW"
                    ]
                  }
                }
              }
            }
          ]
        }
      }
    ]
  })
}
