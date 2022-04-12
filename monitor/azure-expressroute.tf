resource "datadog_monitor" "azure-er-status" {
  name                = "ER Status Degraded {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.network_expressroutecircuits.status{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}