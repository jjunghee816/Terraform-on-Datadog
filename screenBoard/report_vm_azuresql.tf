resource "datadog_dashboard" "reportboard_vm_mysql" {
  title        = "Report Screenboard"
  description  = "Created using the Datadog provider in Terraform"
  layout_type  = "free"

  widget {
    note_definition {
      content          = "# VM Count"
      background_color = "blue"
      font_size        = "56"
      text_align       = "center"
      vertical_align   = "center"
      show_tick        = true
      tick_edge        = "bottom"
      tick_pos         = "25%"
      has_padding      = true
    }
    widget_layout {
      height = 6
      width  = 20
      x      = 0
      y      = 0
    }
  }

  widget {
    query_value_definition {
      request {
        q          = "sum:azure.vm.count{name:*,status:running}"
        aggregator = "avg"
      }
      autoscale   = true
      custom_unit = "ea"
      precision   = "0"
      title       = "Current Running"
      title_size  = 16
      text_align  = "center"
      live_span   = "1mo"
    }
    widget_layout {
      height = 10
      width  = 20
      x      = 0
      y      = 8
    }
  }

  widget {
    query_value_definition {
      request {
        q          = "sum:azure.vm.count{*}"
        aggregator = "avg"
      }
      autoscale   = true
      custom_unit = "ea"
      precision   = "0"
      title       = "Azure Integration"
      title_size  = 16
      text_align  = "center"
      live_span   = "1mo"
    }
    widget_layout {
      height = 10
      width  = 20
      x      = -8
      y      = 19
    }
  }

  widget {
    query_value_definition {
      request {
        q          = "sum:datadog.process.agent{host:*}"
        aggregator = "avg"
      }
      autoscale   = true
      custom_unit = "ea"
      precision   = "0"
      title       = "Datadog Agent"
      title_size  = 16
      text_align  = "center"
      live_span   = "1mo"
    }
    widget_layout {
      height = 10
      width  = 20
      x      = 0
      y      = 30
    }
  }

  widget {
    note_definition {
      content          = "##Your_Message##"
      background_color = "gray"
      font_size        = "16"
      text_align       = "left"
      vertical_align   = "center"
      show_tick        = false
      has_padding      = true
    }
    widget_layout {
      height = 9
      width  = 20
      x      = 0
      y      = 41
    }
  }

  widget {
    query_table_definition {
      request {
        q                 = "100-(avg:system.cpu.idle{*} by {host})"
        aggregator        = "avg"
        alias             = "AVG CPU(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "100-(min:system.cpu.idle{*} by {host})"
        aggregator        = "max"
        alias             = "MAX CPU(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "(avg:system.mem.total{*} by {host}-avg:system.mem.usable{*} by {host})/avg:system.mem.total{*} by {host}*100"
        aggregator        = "avg"
        alias             = "AVG MEM(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "(max:system.mem.total{*} by {host}-max:system.mem.usable{*} by {host})/max:system.mem.total{*} by {host}*100"
        aggregator        = "max"
        alias             = "MAX MEM(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      title          = "VM Usage Percent"
      title_size     = 16
      title_align    = "left"
      has_search_bar = "auto"
    }
    widget_layout {
      height = 90
      width  = 60
      x      = 21
      y      = 0
    }
  }

  widget {
    query_table_definition {
      request {
        q                 = "avg:azure.dbformysql_servers.cpu_percent{*} by {name}"
        aggregator        = "avg"
        alias             = "AVG CPU(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "max:azure.dbformysql_servers.cpu_percent{*} by {name}"
        aggregator        = "max"
        alias             = "MAX CPU(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "80"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "60"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "60"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "avg:azure.dbformysql_servers.memory_percent{*} by {name}"
        aggregator        = "avg"
        alias             = "AVG MEM(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "80"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "60"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "60"
          palette    = "black_on_light_green"
        }
      }
      request {
        q                 = "max:azure.dbformysql_servers.memory_percent{*} by {name}"
        aggregator        = "max"
        alias             = "MAX MEM(%)"
        order             = "desc"
        limit             = "100"
        conditional_formats {
          comparator = ">="
          value      = "90"
          palette    = "black_on_light_red"
        }
        conditional_formats {
          comparator = ">="
          value      = "70"
          palette    = "black_on_light_yellow"
        }
        conditional_formats {
          comparator = "<"
          value      = "70"
          palette    = "black_on_light_green"
        }
      }
      title          = "MySQL Usage Percent"
      title_size     = 16
      title_align    = "left"
      has_search_bar = "auto"
    }
    widget_layout {
      height = 90
      width  = 60
      x      = 82
      y      = -1
    }
  }
  
}