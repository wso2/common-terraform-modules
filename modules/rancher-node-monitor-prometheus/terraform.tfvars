grafana_url  = "https://monitoring-lk.dc.sys.wso2.com/"
grafana_auth = ""
servicenow_username = "" 
servicenow_password = ""

prometheus_datasource_name = "Prometheus"
folder_title               = "Harvester VM Alerts WDT NonProd"
servicenow_url             = "https://wso2.service-now.com/api/wso2/v1/sre_alert_api/prometheus"

common_labels = {
  component   = "system"
  service     = "client-ditsub-alert-integration"
  environment = "NonProd"
  category    = "service_interruption"
  severity    = "critical"
}

memory_usable_pct = { warning = 20, critical = 10 }
disk_free_pct     = { warning = 20, critical = 10 }
cpu_used_pct      = { warning = 80, critical = 90 }
