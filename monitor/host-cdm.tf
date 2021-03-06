resource "datadog_monitor" "host-cpu" {
  name                = "CPU Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):100 - avg:system.cpu.idle{*} by {name,host} > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-memory" {
  name                = "Memory Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_5m):( avg:system.mem.total{*} by {name,host} - avg:system.mem.usable{*} by {name,host} ) / avg:system.mem.total{*} by {name,host} * 100 > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-memory-forecast" {
  name                = "[Forecast] Memory Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})' within the next week"
  type                = "metric alert"
  query               = "max(next_1w):forecast(( avg:system.mem.total{*} by {name,host} - avg:system.mem.usable{*} by {name,host} ) / avg:system.mem.total{*} by {name,host} * 100, 'seasonal', 1, model='default', interval='60m', history='1w', seasonality='weekly', timezone='Asia/Seoul') > 93"
  notify_no_data      = false
  no_data_timeframe   = 10
  new_group_delay     = 60
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Forecast Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-disk" {
  name                = "Disk '{{device.name}}' Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "avg(last_3m):avg:system.disk.in_use{device:/dev/s* OR device:*: OR device://*} by {name,host,device} * 100 >= 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 60
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Disk*** : {{device.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{last_triggered_at}}{{{{raw}}}}(UTC){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-disk-forecast" {
  name                = "[Forecast] Disk '{{device.name}}' Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})' within the next week"
  type                = "metric alert"
  query               = "max(next_1w):forecast(system.disk.in_use{device:/dev/s* OR device:*: OR device://*} by {name} * 100, 'seasonal', 1, model='default', interval='60m', history='1w', seasonality='weekly', timezone='Asia/Seoul') > 85"
  notify_no_data      = false
  no_data_timeframe   = 10
  new_group_delay     = 60
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Disk*** : {{device.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-disk-queue" {
  name                = "OS Disk IOps Consumed Percent {{comparator}} {{threshold}} on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "min(last_15m):avg:azure.vm.os_disk_iops_consumed_percentage{*} by {name,host} > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}