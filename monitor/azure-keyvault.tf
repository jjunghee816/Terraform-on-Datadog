resource "datadog_monitor" "azure-key-status" {
  name                = "Key Vault Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.keyvault_vaults.status{status:running} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}