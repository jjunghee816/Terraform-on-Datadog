variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}

variable "noti_channel" {
  type      = string
  sensitive = true
}

variable "url" {
  type = map(string)
}

variable "ssl_port" {
  type      = number
  sensitive = true
}

variable "tag" {
  type = string
}