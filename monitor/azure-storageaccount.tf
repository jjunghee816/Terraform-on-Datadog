resource "datadog_monitor" "azure-storage-transaction" {
  name                = "SA Transaction {{comparator}} 100K on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.storage.transactions{*} by {name,resource_group} >= 100000"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}