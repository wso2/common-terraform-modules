grafana_url  = "https://monitoring-lk.dc.sys.wso2.com/"
grafana_auth = ""
servicenow_username = "" 
servicenow_password = ""

prometheus_datasource_name = "Prometheus"
folder_title               = "sample folder name for prometheus"
servicenow_url             = "sample_webhook _url"

common_labels = {
  component   = "system"
  service     = "example_service"
  environment = "enviornment ex:nonprod"
  category    = "service_interruption"
  severity    = "critical"
}

memory_usable_pct = { warning = 20, critical = 10 }
disk_free_pct     = { warning = 20, critical = 10 }
cpu_used_pct      = { warning = 80, critical = 90 }
