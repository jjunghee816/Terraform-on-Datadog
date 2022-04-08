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

variable "url_name" {
  type = list(any)
}

variable "url_address" {
  type      = list(any)
  sensitive = true
}

variable "url_host" {
  type      = list(any)
  sensitive = true
}

variable "ssl_port" {
  type      = number
  sensitive = true
}

variable "tag" {
  type = string
}