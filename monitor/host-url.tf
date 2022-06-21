resource "datadog_monitor" "host-url-metric" {
  name                = "URL '{{instance.name}}' Disconnected on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:network.http.can_connect{*} by {host,instance,url} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  require_full_window = true
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}})\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-url-network" {
  name                = "URL '{{instance.name}}' Disconnected on '{{host.name}}({{host.ip}})'"
  type                = "service check"
  query               = "'http.can_connect'.over('*').by('host','instance','url').last(2).count_by_status()"
  notify_no_data      = true
  no_data_timeframe   = 10
  require_full_window = true
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}}){{#is_alert}}\n- ***Message*** : {{check_message}}{{/is_alert}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-ssl-now" {
  name                = "URL '{{instance.name}}' SSL Expires on '{{host.name}}({{host.ip}})'"
  type                = "service check"
  query               = "'http.ssl_cert'.over('*').by('host','instance','url').last(2).count_by_status()"
  notify_no_data      = true
  no_data_timeframe   = 10
  require_full_window = true
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}}){{#is_alert}}\n- ***Message*** : {{check_message}}{{/is_alert}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "host-ssl-30" {
  name                = "URL '{{instance.name}}' SSL Expires in 30 Days on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "avg(last_1d):avg:http.ssl.days_left{*} by {host,instance,url} < 30"
  notify_no_data      = true
  no_data_timeframe   = 10
  new_group_delay     = 300
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}}){{#is_alert}}\n- ***Message*** : {{check_message}}{{/is_alert}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}