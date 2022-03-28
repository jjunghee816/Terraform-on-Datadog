resource "datadog_monitor" "azure-disk-queue" {
  name                = "OS Disk IOps Consumed Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.vm.os_disk_iops_consumed_percentage{*} by {name,host} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}