resource "datadog_monitor" "host-process-cpu" {
  name                = "Process '{{process_name}}' CPU Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:system.processes.cpu.normalized_pct{process_name:*} by {name,host,process_name} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Process*** : {{process_name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel_exclude_noc}"
  priority            = 2
}

resource "datadog_monitor" "host-process-memory" {
  name                = "Process '{{process_name}}' Memory Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:system.processes.mem.pct{process_name:*} by {name,host,process_name} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Process*** : {{process_name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel_exclude_noc}"
  priority            = 2
}

resource "datadog_monitor" "host-disk-device" {
  name                = "Disk '{{device.name}}' Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "avg(last_3m):avg:system.disk.in_use{device:/dev/s* OR device:*: OR device://*} by {name,host,device} * 100 >= 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Disk*** : {{device.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{last_triggered_at}}{{{{raw}}}}(UTC){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}