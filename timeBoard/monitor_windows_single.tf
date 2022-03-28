resource "datadog_dashboard" "timeboard_windows" {
  title        = "Monitoring Timeboard"
  description  = "Created using the Datadog provider in Terraform"
  layout_type  = "ordered"
  
  widget {
    group_definition {
      layout_type     = "ordered"
      title           = "Status"

      widget {
        check_status_definition {
          check       = "datadog.agent.up"
          grouping    = "cluster"
          group_by    = ["host"]
          tags        = ["*"]
          title       = "Running Agent Count"
          title_size  = "16"
          title_align = "left"
          live_span   = "1h"
        }
      }

      widget {
        check_status_definition {
          check       = "tcp.can_connect"
          grouping    = "cluster"
          group_by    = ["port"]
          tags        = ["*"]
          title       = "Open Port Count"
          title_size  = "16"
          title_align = "left"
          live_span   = "1h"
        }
      }

      widget {
        check_status_definition {
          check       = "process.up"
          grouping    = "cluster"
          group_by    = ["process_name"]
          tags        = ["*"]
          title       = "Running Process Count"
          title_size  = "16"
          title_align = "left"
          live_span   = "1h"
        }
      }

      widget {
        check_status_definition {
        check         = "http.can_connect"
        grouping      = "cluster"
        group_by      = ["url"]
        tags          = ["*"]
        title         = "Connect URL Count"
        title_size    = "16"
        title_align   = "left"
        live_span     = "1h"
        }
      }

      widget {
        query_value_definition {
          request {
            q            = "avg:azure.network_publicipaddresses.if_under_d_do_s_attack{name:*}.as_count()"
            aggregator   = "last"
            conditional_formats {
            comparator   = "<="
            value        = "0"
            palette      = "white_on_green"
            }
            conditional_formats {
              comparator = ">"
              value      = "0"
              palette    = "white_on_red"
            }
        }
        autoscale   = true
        custom_unit = ""
        precision   = "4"
        text_align  = "center"
        title       = "Public IP under DDoS Attack"
        live_span   = "1h"
        }
      }

      widget {
        query_value_definition {
          request {
            q            = "avg:system.uptime{host:*}"
            aggregator   = "avg"
            conditional_formats {
              comparator = ">"
              value      = "15552000"
              palette    = "white_on_red"
            }
            conditional_formats {
              comparator = ">"
              value      = "2592000"
              palette    = "white_on_yellow"
            }
            conditional_formats {
              comparator = "<="
              value      = "2592000"
              palette    = "white_on_green"
            }
          }
          autoscale   = true
          precision   = "0"
          text_align  = "center"
          title       = "Server Uptime"
          live_span   = "1h"
        }
      }

    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "100-avg:system.cpu.idle{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "100-avg:system.cpu.idle{*} by {host}"
          alias_name = "CPU %"
        }
      }
      marker {
        display_type = "error solid"
        value        = "y = 90"
      }
      title           = "CPU Usage(%)"
      title_size      = "16"
      title_align     = "left"
      live_span       = "1h"
      show_legend     = true
      legend_size     = "2"
      legend_layout   = "auto"
      event {
        q = "CPU Usage"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "(avg:system.mem.total{*} by {host} - avg:system.mem.usable{*} by {host}) / avg:system.mem.total{*} by {host} * 100"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "(avg:system.mem.total{*} by {host} - avg:system.mem.usable{*} by {host}) / avg:system.mem.total{*} by {host} * 100"
          alias_name = "Memory %"
        }
      }
      marker {
        display_type = "error solid"
        value        = "y = 90"
      }
      title          = "Memory Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Memory Usage"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.disk.in_use{device:*:} by {host,device} * 100"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.disk.in_use{device:*:} by {host,device} * 100"
          alias_name = "Disk %"
        }
      }
      marker {
        display_type = "error solid"
        value        = "y = 90"
      }
      title          = "Disk Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Usage"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.rkb_s{*} by {host}"
        display_type = "line"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.rkb_s{*} by {host}"
          alias_name = "Read Request(KiB)"
        }
      }
      request {
        q            = "avg:system.io.wkb_s{*} by {host}"
        display_type = "line"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.wkb_s{*} by {host}"
          alias_name = "Write Request(KiB)"
        }
      }
      title          = "System I/O"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System I/O"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.net.bytes_sent{*} by {host}"
        display_type = "line"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.net.bytes_sent{*} by {host}"
          alias_name = "Network Out"
        }
      }
      request {
        q            = "avg:system.net.bytes_rcvd{*} by {host}"
        display_type = "line"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.net.bytes_rcvd{*} by {host}"
          alias_name = "Network In"
        }
      }
      title          = "Network Traffic I/O"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Network I/O"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.vm.disk_read_bytes{*} by {host}"
        display_type = "line"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.disk_read_bytes{*} by {host}"
          alias_name = "Disk Read"
        }
      }
      request {
        q            = "avg:azure.vm.disk_write_bytes{*} by {host}"
        display_type = "line"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.disk_write_bytes{*} by {host}"
          alias_name = "Disk Write"
        }
      }
      title          = "Disk I/O"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk I/O"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.vm.disk_read_operations_sec{*} by {host}"
        display_type = "line"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.disk_read_operations_sec{*} by {host}"
          alias_name = "Read Operations"
        }
      }
      request {
        q            = "avg:azure.vm.disk_write_operations_sec{*} by {host}"
        display_type = "line"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.disk_write_operations_sec{*} by {host}"
          alias_name = "Write Operations"
        }
      }
      title          = "Disk Operations"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Operations"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.vm.os_disk_queue_depth{*} by {host}"
        display_type = "line"
        style {
          palette    = "cool"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.os_disk_queue_depth{*} by {host}"
          alias_name = "OS Disk"
        }
      }
      request {
        q            = "avg:azure.vm.data_disk_queue_depth{*} by {host}"
        display_type = "line"
        style {
          palette    = "purple"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.vm.data_disk_queue_dept{*} by {host}"
          alias_name = "Data Disk"
        }
      }
      title          = "Disk Queue Depth"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Queue Depth"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:synthetics.api.response{*} by {url}.as_count()"
        display_type = "bars"
        style {
          palette    = "dog_classic"
        }
        metadata {
          expression = "sum:synthetics.api.response{*} by {url}.as_count()"
          alias_name = "URL Response"
        }
      }
      title          = "Synthetics URL Response"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Synthetics URL Response"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:azure.vm.sql_server_general_statistics_user_connections{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "sum:azure.vm.sql_server_general_statistics_user_connectionsc{*} by {host}"
          alias_name = "SQL User Connection"
        }
      }
      title          = "SQL User Connection Count"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "SQL User Connection Count"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:azure.vm.sql_server_sql_statistics_batch_requests_per_sec{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "sum:azure.vm.sql_server_sql_statistics_batch_requests_per_sec{*} by {host}"
          alias_name = "SQL Request"
        }
      }
      title          = "SQL Request Count"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "SQL Request Count"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:azure.vm.sql_server_sql_statistics_sql_compilations_per_sec{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "sum:azure.vm.sql_server_sql_statistics_sql_compilations_per_sec{*} by {host}"
          alias_name = "SQL Compilations"
        }
      }
      title          = "SQL Compilations Count"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Compilations Count"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.processes.cpu.normalized_pct{*} by {host,process_name}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.processes.cpu.normalized_pct{*} by {host,process_name}"
          alias_name = "CPU %"
        }
      }
      marker {
        display_type = "error solid"
        value        = "y = 80"
      }
      title          = "Process CPU Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Process CPU Usage"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.processes.mem.pct{*} by {host,process_name}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.processes.mem.pct{*} by {host,process_name}"
          alias_name = "Memory %"
        }
      }
      marker {
        display_type = "error solid"
        value        = "y = 80"
      }
      title          = "Process Memory Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Process Memory Usage"
      }
    }
  }

}