resource "datadog_monitor" "azure-cosmosdb-ru-db" {
  name                = "Cosmos DB RU {{comparator}} {{threshold}} '{{name.name}}({{databasename.name}})'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.cosmosdb.normalized_ru_consumption{*} by {name,databasename,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Database*** : {{databasename.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-cosmosdb-ru-collect" {
  name                = "Cosmos DB RU Collection {{comparator}} {{threshold}} '{{name.name}}({{collectionname.name}})'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.cosmosdb.normalized_ru_consumption{*} by {name,collectionname,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Collection*** : {{collectionname.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-cosmosdb-429-db" {
  name                = "Cosmos DB Throttled {{comparator}} {{threshold}} '{{name.name}}({{databasename.name}})'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.cosmosdb.total_requests{statuscode:429} by {name,databasename,statuscode,resource_group}.as_count() > 25"
  notify_no_data      = false
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Database*** : {{databasename.name}}\n- ***Statud Code*** : {{statuscode.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-cosmosdb-429-collect" {
  name                = "Cosmos DB Collection Throttled {{comparator}} {{threshold}} '{{name.name}}({{collectionname.name}})'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.cosmosdb.total_requests{statuscode:429} by {name,collectionname,statuscode,resource_group}.as_count() > 25"
  notify_no_data      = false
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Collection*** : {{collectionname.name}}\n- ***Statud Code*** : {{statuscode.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}