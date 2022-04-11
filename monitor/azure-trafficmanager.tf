resource "datadog_monitor" "azure-trafficmanager-status" {
  name                = "TrafficManager Endpoint Status Degraded on '{{name.name}}'"
  type                = "metric alert"
  query               = "max(last_5m):avg:azure.network_trafficmanagerprofiles.probe_agent_current_endpoint_state_by_profile_resource_id{*} by {name,resource_group} < 1"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}