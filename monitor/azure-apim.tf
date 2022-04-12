resource "datadog_monitor" "azure-apim-load" {
  name                = "APIM Usage Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.apimanagement_service.capacity{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}