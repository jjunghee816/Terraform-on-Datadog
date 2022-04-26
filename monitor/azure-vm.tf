resource "datadog_monitor" "azure-vm-cpu" {
  name                = "CPU Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "min(last_5m):azure.vm.percentage_cpu{*} by {name,resource_group} > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

# resource "datadog_monitor" "azure-vm-memory" {
#   name                = "Memory Percent {{comparator}} {{threshold}} on '{{host.name}}'"
#   type                = "metric alert"
#   query               = "min(last_5m):azure.vm.available_memory_bytes_preview{*} by {name,resource_group} > 90"
#   notify_no_data      = true
#   no_data_timeframe   = 10
#   new_group_delay     = 300
#   require_full_window = false
#   include_tags        = false
#   message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
#   priority            = 2
# }