resource "datadog_monitor" "azure-iothub-messages" {
  name                = "IoT Hub Total Messages {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.devices_iothubs.total_number_of_messages_used{*} by {name} / 400000 * 100 >= 70"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}