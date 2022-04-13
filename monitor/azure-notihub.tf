resource "datadog_monitor" "azure-notihub-status" {
  name                = "NotificationHubs Namespaces Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.notificationhubs_namespaces.status{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}