resource "datadog_monitor" "azure-app-status" {
  name                = "App Service Degraded on '{{name.name}}({{kind.name}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.app_services.status{*} by {name,kind,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Kind*** : {{kind.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-app-health" {
  name                = "App Service Health Check Degraded on '{{name.name}}({{kind.name}})'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.app_services.health_check_status{*} by {name,kind,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Kind*** : {{kind.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-app-http5xx" {
  name                = "Web HTTP 500 Error {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.app_services.http5xx{*} by {name,resource_group}.as_count() > 10"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}