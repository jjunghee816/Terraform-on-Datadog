resource "datadog_monitor" "azure-postgresql-cpu" {
  name                = "PostgreSQL CPU Percent {{comparator}} {{threshold}} on '{{name.name}}'"
  type                = "metric alert"
  query               = "avg(last_5m):avg:azure.dbforpostgresql_servers.cpu_percent{name:postgre-s1bims-prd-krc-01} by {name} >= 80"
  notify_no_data      = true
  no_data_timeframe   = 10
  evaluation_delay    = 0
  require_full_window = false
  include_tags        = false
  message             = "- ***Target*** : {{name.name}}\n- ***Current Value*** : {{value}}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  priority            = 2
}