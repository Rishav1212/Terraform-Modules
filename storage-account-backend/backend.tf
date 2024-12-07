terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-resource-group"
    storage_account_name = "rishavstorageaccout12"
    container_name       = "rishav"
    key                  = "terraform.tfstate"
  }
}
