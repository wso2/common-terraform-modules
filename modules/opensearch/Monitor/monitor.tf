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

resource "opensearch_channel_configuration" "channel_configuration" {
  body = <<EOF
{
  "config_id": ${var.channel-configuration.id},
  "config": {
    "name": ${var.channel-configuration.name},
    "description": ${var.channel-configuration.description},
    "config_type": "webhook",
    "is_enabled": ${var.channel-configuration.enabled},
    "webhook": {
      "url": ${var.channel-configuration.webhook}
    }
  }
}
EOF
}

resource "opensearch_monitor" "pdp_monitor_1" {
  depends_on = [
    opensearch_channel_configuration.channel_configuration
  ]
  body = <<EOF
{
   "type":${var.monitor-configuration.type},
   "name":${var.monitor-configuration.name},
   "monitor_type":${var.monitor-configuration.monitor_type},
   "enabled":${var.monitor-configuration.enabled},
   "schedule":{
      "period":{
         "interval":${var.monitor-schedule.interval},
         "unit":${var.monitor-schedule.unit}
      }
   },
   "inputs":[
       {
         "search":{
            "indices":[
               "container-logs-*"
            ],
            "query":{
               "size":0,
               "query":{
                  "bool":{
                     "filter":[
                        {
                           "range":{
                              "@timestamp":{
                                 "from": ${var.monitor-query-search-range.from},
                                 "to": ${var.monitor-query-search-range.to},
                                 "include_lower": true,
                                 "include_upper": true,
                                 "format": "epoch_millis",
                                 "boost": 1
                              }
                           }
                        },
                        {
                           "term":{
                              "kubernetes.namespace_name":{
                                 "value":${var.log-search-namespace}
                              }
                           }
                        },
                        {
                           "term": {
                              "kubernetes.container_name": {
                                 "value": ${var.log-search-container},
                                 "boost": 1
                              }
                          }
                        },
                        {
                          "wildcard": {
                              "log": {
                                  "wildcard": ${var.log-search-phrase},
                                  "boost": 1
                              }
                          }
                      }
                     ],
                     "adjust_pure_negative": true,
                     "boost": 1
                  }
               },
               "aggregations": {
                  "by_time": {
                      "date_histogram": {
                          "field": "@timestamp",
                          "format": "epoch_millis",
                          "fixed_interval": ${var.log-aggregation-fixed-interval},
                          "offset": 0,
                          "order": {
                              "_key": "asc"
                          },
                          "keyed": false,
                          "min_doc_count": ${var.log-aggregation-min-doc-count}
                      }
                  }
              }
            }
         }
      }
   ],
   "triggers":[
      {
         "bucket_level_trigger": {
            "name":${var.trigger-config-name},
            "severity":"1",
            "condition":{
               "buckets_path":{
                  "log_count":"_count"
               },
               "parent_bucket_path":"number_of_matching_logs",
               "script":{
                  "source":${var.trigger-config-script.source},
                  "lang":${var.trigger-config-script.lang}
               }
            },
            "actions":[
               {
                  "name": ${var.monitor-action-trigger.name},
                  "destination_id": ${var.monitor-action-trigger.destination_id},
                  "message_template": {
                     "source":"{ \"monitorId\": \"{{ctx.monitor._id}}\", \"monitorName\": \"{{ctx.monitor.name}}\", \"monitorType\": \"{{ctx.monitor.type}}\", \"triggerName\": \"{{ctx.trigger.name}}\", \"triggerSeverity\": \"{{ctx.trigger.severity}}\", \"periodStart\": \"{{ctx.periodStart}}\", \"periodEnd\": \"{{ctx.periodEnd}}\",\"logCount\": \"{{ctx.results.0.hits.total.value}}\",\"type\": \"logs\"}",
                     "lang": "mustache"
                  },
                  "throttle_enabled": false,
                  "subject_template": {
                     "source": "Alerting Notification action",
                     "lang": "mustache"
                  },
                  "action_execution_policy": {
                     "action_execution_scope": {
                        "per_alert": {
                           "actionable_alerts": [
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
}
EOF
}

