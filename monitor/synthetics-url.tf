resource "datadog_synthetics_test" "synthetics-url-status-count" {
  count   = length(var.url_name)
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = element(var.url_address, count.index)
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  assertion {
    type     = "responseTime"
    operator = "lessThan"
    target   = "3000"
  }
  locations = [
    "aws:ap-northeast-2",
    "azure:eastus",
    "##Location you want to monitor##"
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
    min_location_failed  = 2
  }
  name    = "URL Check on '${element(var.url_name, count.index)}'"
  message = "- ***URL*** : [${element(var.url_name, count.index)}](${element(var.url_address, count.index)})\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  tags    = ["${var.tag}"]
  status  = "live"
}

resource "datadog_synthetics_test" "synthetics-url-status-foreach" {
  for_each = var.url
  type     = "api"
  subtype  = "http"
  request_definition {
    method = "GET"
    url    = each.value
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  assertion {
    type     = "responseTime"
    operator = "lessThan"
    target   = "3000"
  }
  locations = [
    "aws:ap-northeast-2",
    "azure:eastus"
  ]
  options_list {
    tick_every = 60
    retry {
      count    = 3
      interval = 1500
    }
    monitor_options {
      renotify_interval = 60
    }
    min_failure_duration = 50
    min_location_failed  = 2
  }
  name    = "URL Check on '${each.key}'"
  message = "- ***URL*** : [${each.key}](${each.value})\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}{{#is_alert_recovery}}\n- ***Duration*** : {{triggered_duration_sec}}{{{{raw}}}} seconds{{{{/raw}}}}{{/is_alert_recovery}}\n- ***Notification Channel*** : \n${var.noti_channel}"
  tags    = ["${var.tag}"]
  status  = "live"
}