resource "datadog_monitor" "azure-sql-status" {
  name                = "SQL Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_15m):avg:azure.sql_servers_databases.status{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 0
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-sql-connection" {
  name                = "SQL Connection Failed {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.sql_servers_databases.connection_failed{*} by {name,resource_group}.as_count() > 50"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-sql-dtu" {
  name                = "SQL DTU Usage Percent {{comparator}} {{threshold}} on '{{name.name}}({{server_name.name}})'"
  type                = "metric alert"
  query               = "avg(last_15m):avg:azure.sql_servers_databases.dtu_consumption_percent{*} by {name,server_name,resource_group} > 90"
  notify_no_data      = true
  no_data_timeframe   = 0
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}({{server_name.name}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-sql-dtu-divide" {
  name                = "SQL DTU Usage Percent {{comparator}} {{threshold}} on '{{name.name}}({{server_name.name}})'"
  type                = "metric alert"
  query               = "avg(last_15m):( avg:azure.sql_servers_databases.dtu_used{*} by {name,server_name,resource_group}.as_rate() / avg:azure.sql_servers_databases.dtu_limit{*} by {name,server_name,resource_group}.as_rate() ) * 100 > 90"
  notify_no_data      = true
  no_data_timeframe   = 0
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}({{server_name.name}})\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-sql-storage" {
  name                = "SQL Storage Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.sql_servers_databases.storage_percent{*} by {name,resource_group} > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}