resource "datadog_synthetics_test" "test_ssl" {
    count        = "${length(var.url_host)}"
    type         = "api"
    subtype      = "ssl"
    request_definition {
        host     = "${element(var.url_host, count.index)}"
        port     = "${var.ssl_port}"
    }
    assertion {
        type     = "certificate"
        operator = "isInMoreThan"
        target   = 30
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
        accept_self_signed = true
        retry {
        count    = 2
        interval = 300
        }
        monitor_options {
        renotify_interval = 100
        }
    }
    name    = "SSL Expires in 30 Days on '${element(var.url_host, count.index)}'"
    message = "- ***Domain*** : ${element(var.url_host, count.index)}\n- ***Port*** : ${(var.ssl_port)}\n- ***Last*** : {{local_time 'last_triggered_at' 'Asia/Seoul'}}{{{{raw}}}}(KST){{{{/raw}}}}\n- ***Notification Channel*** : \n${var.noti_channel}"
    tags    = ["${var.tag}"]
    
    status = "live"
}