terraform {
  required_providers {
    datadog   = {
      source  = "DataDog/datadog"
      version = ">=0.13"
    }
  }
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}