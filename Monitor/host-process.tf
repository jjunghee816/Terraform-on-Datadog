resource "datadog_monitor" "host-process-status" {
  name                = "Process '{{process.name}}' Down on '{{host.name}}({{host.ip}})'"
  type                = "service check"
  query               = "'process.up'.over('*').by('name','host','process').last(2).count_by_status()"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_host_delay      = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Process*** : {{process.name}}\n- ***Message*** : {{check_message}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 1
}

resource "datadog_monitor" "host-process-cpu" {
  name                = "Process '{{process_name}}' CPU Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:system.processes.cpu.normalized_pct{process_name:*} by {name,host,process_name} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_host_delay      = 300
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
  new_host_delay      = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Process*** : {{process_name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel_exclude_noc}"
  priority            = 2
}

resource "datadog_monitor" "windows-services" {
  name                = "Windows Service '{{windows_service.name}}' Down on '{{name.name}}({{host.ip}})'"
  type                = "service check"
  query               = "'windows_service.state'.over('*').by('name','host','windows_service').last(2).count_by_status()"
  notify_no_data      = true
  no_data_timeframe   = 5
  new_host_delay      = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Service*** : {{windows_service.name}}\n- ***Message*** : {{check_message}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 1
}