terraform {
  backend "azurerm" {
    resource_group_name  = "##ResourceGroup Name##"
    storage_account_name = "##Storageaccount Name##"
    container_name       = "##Blob Container Name##"
    key                  = "directory/directory/terraform.tfstate"
    subscription_id      = "##Subscription Id##"
    tenant_id            = "##Tenant Id##"
    access_key           = "##StorageAccount Access Key##"
  }
}