resource "datadog_monitor" "azure-mysql-connection" {
  name                = "MySQL Connection Failed {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.dbformysql_servers.connections_failed{*} by {name,resource_group}.as_count() > 50"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-mysql-cpu" {
  name                = "MySQL CPU Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.dbformysql_servers.cpu_percent{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-mysql-memory" {
  name                = "MySQL Memory Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.dbformysql_servers.memory_percent{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-mysql-replica" {
  name                = "MySQL Replica Behind Master {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.dbformysql_servers.seconds_behind_master{name:*replica} by {name,resource_group}.as_count() > 50"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = true
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-mysql-storage" {
  name                = "MySQL Storage Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.dbformysql_servers.storage_percent{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-mysql-serverlog" {
  name                = "MySQL ServerLog Storage Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.dbformysql_servers.serverlog_storage_percent{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}