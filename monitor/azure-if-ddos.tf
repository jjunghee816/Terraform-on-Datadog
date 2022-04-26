resource "datadog_monitor" "azure-ddos" {
  name                = "Public IP under DDoS Attack on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_15m):avg:azure.network_publicipaddresses.if_under_d_do_s_attack{*} by {name,resource_group} > 0"
  notify_no_data      = true
  no_data_timeframe   = 0
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}