resource "datadog_monitor" "azure-apim-status" {
  name                = "APIM Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.apimanagement_service.status{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 1
}

resource "datadog_monitor" "azure-apim-status" {
  name                = "APIM Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.apimanagement_service.count{status:running} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 1
}

resource "datadog_monitor" "azure-apim-load" {
  name                = "APIM Usage Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.apimanagement_service.capacity{*} by {name,resource_group} > 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-apim-fail" {
  name                = "APIM Requests Failed {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.apimanagement_service.failed_requests{*} / avg:azure.apimanagement_service.total_requests{*} by {name,resource_group} * 100 > 70"
  notify_no_data      = false
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-apim-http5xx" {
  name                = "APIM HTTP 500 Errors {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "sum(last_5m):avg:azure.apimanagement_service.requests{gatewayresponsecodecategory:5xx} by {name,hostname,gatewayresponsecode,resource_group}.as_count() > 10"
  notify_no_data      = false
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Response Code*** : {{gatewayresponsecode.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}