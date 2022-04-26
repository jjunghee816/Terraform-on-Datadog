resource "datadog_synthetics_test" "synthetics-tcp" {
  for_each = var.port
  type    = "api"
  subtype = "tcp"
  request_definition {
      host = each.value.ip
      port = each.value.port
  }
  assertion {
    type     = "responseTime"
    operator = "lessThan"
    target   = "1000"
  }
  locations = [
    "aws:us-east-2",
    "aws:eu-west-3",
    "aws:ap-southeast-1",
    "aws:ap-northeast-2",
    "azure:eastus",
  ]
  options_list {
    tick_every = 60
    retry {
      count    = 3
      interval = 1500
    }
    monitor_options {
      renotify_interval = 120
    }
    min_failure_duration = 50
    min_location_failed  = 3
  }
  name    = "TCP Port Check on '${each.value.ip}:${each.value.port}'"
  message = "- ***URL*** : ${each.value.ip}\n- ***Port*** : ${each.value.port}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  tags    = ["${var.tag}"]
  status  = "live"
}