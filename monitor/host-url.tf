resource "datadog_monitor" "host-url-metric" {
  name                = "URL '{{instance.name}}' Disconnected on '{{host.name}}({{host.ip}})'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:network.http.can_connect{*} by {host,instance,url} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  require_full_window = true
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}})\n- ***Message*** : {{check_message}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
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
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***URL*** : {{instance.name}}({{url.name}})\n- ***Message*** : {{check_message}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}