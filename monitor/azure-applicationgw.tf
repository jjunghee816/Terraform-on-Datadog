resource "datadog_monitor" "azure-agw-status" {
  name                = "Application GW Unhealthy Hosts {{threshold}} on '{{name.name}}"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.network_applicationgateways.unhealthy_host_count{*} by {name,backendsettingspool,resource_group} > 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Backend Pool*** : {{backendsettingspool.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}