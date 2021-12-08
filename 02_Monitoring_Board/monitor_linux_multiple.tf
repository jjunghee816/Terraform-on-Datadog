resource "datadog_dashboard" "timeboard_linux_jump" {
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
        query_value_definition {
          request {
            q            = "sum:synthetics.api.response{*} by {url}.as_count()"
            aggregator   = "last"
            conditional_formats {
            comparator   = ">="
            value        = "1"
            palette      = "white_on_green"
            }
            conditional_formats {
              comparator = "<"
              value      = "1"
              palette    = "white_on_red"
            }
        }
        autoscale   = true
        custom_unit = ""
        precision   = "4"
        text_align  = "center"
        title       = "Connect URL Count"
        live_span   = "1h"
        }
      }

      widget {
        query_value_definition {
          request {
            q            = "avg:azure.network_loadbalancers.health_probe_status{*} by {name}.as_count()"
            aggregator   = "last"
            conditional_formats {
            comparator   = ">="
            value        = "60"
            palette      = "white_on_green"
            }
            conditional_formats {
              comparator = "<"
              value      = "60"
              palette    = "white_on_red"
            }
        }
        autoscale   = true
        custom_unit = ""
        precision   = "4"
        text_align  = "center"
        title       = "LB Health Probe Status"
        live_span   = "1h"
        }
      }

      widget {
        query_value_definition {
          request {
            q            = "avg:azure.network_publicipaddresses.if_under_d_do_s_attack{*} by {name}.as_count()"
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
      title          = "CPU Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
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
        q            = "avg:system.disk.in_use{!device:/dev/loop*} by {host,device} * 100"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.disk.in_use{!device:/dev/loop*} by {host,device} * 100"
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
        q            = "avg:system.load.1{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.load.1{*} by {host}"
          alias_name = "System Load 1"
        }
      }
      title          = "System Load over 1 Minutes"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System Load"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.load.5{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.load.5{*} by {host}"
          alias_name = "System Load 5"
        }
      }
      title          = "System Load over 5 Minutes"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System Load"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.load.15{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.load.15{*} by {host}"
          alias_name = "System Load 15"
        }
      }
      title          = "System Load over 15 Minutes"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System Load"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "max:system.cpu.iowait{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "max:system.cpu.iowait{*} by {host}"
          alias_name = "I/O Wait"
        }
      }
      title          = "System CPU I/O Wait(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "CPU I/O Wait"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.r_await{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.r_await{*} by {host}"
          alias_name = "System Read Wait"
        }
      }
      title          = "System Read Wait(ms)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System Read Wait(ms)"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.w_await{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.w_await{*} by {host}"
          alias_name = "System Write Wait"
        }
      }
      title          = "System Write Wait(ms)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "System Write Wait(ms)"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.net.bytes_rcvd{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.net.bytes_rcvd{*} by {host}"
          alias_name = "Network In"
        }
      }
      title          = "Network Traffic In(per Seconds)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Network In"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.net.bytes_sent{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.net.bytes_sent{*} by {host}"
          alias_name = "Network Out"
        }
      }
      title          = "Network Traffic Out(per Seconds)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Network Out"
      }
    }
  }

  widget {
    toplist_definition {
      request {
        q = "sum:azure.network_loadbalancers.byte_count{*} by {name}"
        formula {
          formula_expression = "sum:azure.network_loadbalancers.byte_count{*} by {name}"
          limit {
            count = 10
            order = "desc"
          }
        }
      }
      title = "Highest Total Network Traffic"
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.rkb_s{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.rkb_s{*} by {host}"
          alias_name = "Disk Read"
        }
      }
      title          = "Disk Read(per Seconds)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Read"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.wkb_s{*} by {host}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.wkb_s{*} by {host}"
          alias_name = "Disk Write"
        }
      }
      title          = "Disk Write(per Seconds)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Write"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:system.io.await{*} by {host,device}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:system.io.await{*} by {host,device}"
          alias_name = "Disk Latency"
        }
      }
      title          = "Disk Latency(by Device)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Disk Latency"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.network_loadbalancers.health_probe_status{*} by {name,frontendipaddress,frontendport,backendipaddress,backendport}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.network_loadbalancers.health_probe_status{*} by {name,frontendipaddress,frontendport,backendipaddress,backendport}"
          alias_name = "LB Status"
        }
      }
      title          = "LB Health Probe Status"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "LB Health Probe Status"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.cdn_profiles_endpoints.count{*} by {name}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.cdn_profiles_endpoints.count{*} by {name}"
          alias_name = "CDN Status"
        }
      }
      title          = "CDN Endpoint Status"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "CDN Endpoint"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.network_trafficmanagerprofiles.probe_agent_current_endpoint_state_by_profile_resource_id{*} by {name,endpointname}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.network_trafficmanagerprofiles.probe_agent_current_endpoint_state_by_profile_resource_id{*} by {name,endpointname}"
          alias_name = "TM Status"
        }
      }
      title          = "Traffic Manager Endpoint Status"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Traffic Manager Endpoint"
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
          alias_name = "CPU"
        }
      }
      title          = "Process CPU Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Process CPU"
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
          alias_name = "Memory"
        }
      }
      title          = "Process Memory Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Process Memory"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:azure.dbformysql_servers.connections_failed{*} by {name}.as_count()"
        display_type = "bars"
        style {
          palette    = "dog_classic"
        }
        metadata {
          expression = "sum:azure.dbformysql_servers.connections_failed{*} by {name}.as_count()"
          alias_name = "Connection Failed"
        }
      }
      title          = "MySQL Connection Failure Count"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "MySQL Connection Failure Count"
      }
    }
  }

  widget {
    timeseries_definition {
      request {
        q            = "sum:azure.dbformysql_servers.seconds_behind_master{*} by {name}.as_count()"
        display_type = "bars"
        style {
          palette    = "dog_classic"
        }
        metadata {
          expression = "sum:azure.dbformysql_servers.seconds_behind_master{*} by {name}.as_count()"
          alias_name = "Replica Lag"
        }
      }
      title          = "MySQL Replica Seconds Behind Master"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "MySQL Replica Lag"
      }
    }
  }


  widget {
    timeseries_definition {
      request {
        q            = "avg:azure.dbformysql_servers.cpu_percent{*} by {name}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.dbformysql_servers.cpu_percent{*} by {name}"
          alias_name = "MySQL CPU"
        }
      }
      title          = "MySQL CPU Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "MySQL CPU"
      }
    }
  }

    widget {
    timeseries_definition {
      request {
        q            = "avg:azure.dbformysql_servers.memory_percent{*} by {name}"
        display_type = "line"
        style {
          palette    = "dog_classic"
          line_type  = "solid"
          line_width = "normal"
        }
        metadata {
          expression = "avg:azure.dbformysql_servers.memory_percent{*} by {name}"
          alias_name = "MySQL Memory"
        }
      }
      title          = "MySQL Memory Usage(%)"
      title_size     = "16"
      title_align    = "left"
      live_span      = "1h"
      show_legend    = true
      legend_size    = "2"
      legend_layout  = "auto"
      event {
        q = "Process Memory"
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
    toplist_definition {
      request {
        q = "avg:system.uptime{*} by {host}"
        formula {
          formula_expression = "avg:system.uptime{*} by {host}"
          limit {
            count = 50
            order = "desc"
          }
        }
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
      title = "Highest Server Uptime"
    }
  }

}