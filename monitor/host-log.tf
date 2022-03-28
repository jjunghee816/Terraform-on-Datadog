resource "datadog_monitor" "host-log" {
  name                = "##Search_String## on '{{host.name}}({{host.ip}})'"
  type                = "log alert"
  query               = "logs(\"##search_string##\").index(\"*\").rollup(\"count\").by(\"name\",\"host\").last(\"5m\") > 0"
  enable_logs_sample  = true
  notify_no_data      = false
  no_data_timeframe   = 10
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{host.name}}({{host.ip}})\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}