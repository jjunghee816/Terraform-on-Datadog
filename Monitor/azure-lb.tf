resource "datadog_monitor" "azure-lb-health" {
  name                = "LB Health Probe {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.network_loadbalancers.health_probe_status{name:*} by {name,frontendipaddress,frontendport,backendipaddress,backendport} < 50"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Frontend IP*** : {{frontendipaddress.name}}\n- ***Frontend Port*** : {{frontendport.name}}\n- ***Backend IP*** : {{backendipaddress.name}}\n- ***Backend Port*** : {{backendport.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}