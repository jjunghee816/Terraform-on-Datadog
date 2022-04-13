resource "datadog_monitor" "azure-vmss-status" {
  name                = "VMSS Pool Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):azure.compute_virtualmachinescalesets.status{status:running} by {name,poolname,orchestrator,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Pool*** : {{poolname.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}

resource "datadog_monitor" "azure-vmss-cpu" {
  name                = "VMSS Pool CPU Usage Percent {{comparator}} {{threshold}} on '{{name.name}}({{vmname.name}})'"
  type                = "metric alert"
  query               = "max(last_5m):azure.compute_virtualmachinescalesets.percentage_cpu{*} by {name,poolname,vmname,orchestrator,resource_group} > 90"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}({{vmname.name}})\n- ***Pool*** : {{poolname.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}