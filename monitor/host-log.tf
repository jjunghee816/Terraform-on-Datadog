resource "datadog_monitor" "host-log" {
  name                = "##Search_String## on '{{host.name}}({{host.ip}})'"
  type                = "log alert"
  query               = "logs(\"##search_string##\").index(\"*\").rollup(\"count\").by(\"name\",\"host\").last(\"5m\") > 0"
  enable_logs_sample  = true
  notify_no_data      = false
  no_data_timeframe   = 10
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}}){{#is_alert}}\n- ***Message*** : {{log.message}}{{/is_alert}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}