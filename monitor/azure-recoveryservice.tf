resource "datadog_monitor" "azure-rsv-status" {
  name                = "RSV Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.recoveryservices_vaults.status{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-rsv-backup" {
  name                = "RSV Backup Triggered on '{{name.name}}'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.recoveryservices_vaults.backup_health_event{*} by {name,resource_group} > 0"
  notify_no_data      = false
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-rsv-restore" {
  name                = "RSV Restore Triggered on '{{name.name}}'"
  type                = "metric alert"
  query               = "min(last_5m):avg:azure.recoveryservices_vaults.restore_health_event{*} by {name,resource_group} > 0"
  notify_no_data      = false
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}