resource "datadog_monitor" "azure-cosmosdb-ru-db" {
  name                = "Cosmos DB RU {{comparator}} {{threshold}} '{{name.name}}({{databasename.name}})'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.cosmosdb.normalized_ru_consumption{*} by {name,databasename,resource_group} > 70"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Database*** : {{databasename.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-cosmosdb-ru-collect" {
  name                = "Cosmos DB RU Collection {{comparator}} {{threshold}} '{{name.name}}({{collectionname.name}})'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.cosmosdb.normalized_ru_consumption{*} by {name,collectionname,resource_group} > 70"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Collection*** : {{collectionname.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}