resource "azurerm_resource_group" "rg" {
  name     = "tfstate-resource-group"
  location = "centralindia"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = var.backend_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}