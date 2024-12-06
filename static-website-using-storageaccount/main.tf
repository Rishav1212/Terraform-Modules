resource "azurerm_resource_group" "my_rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_storage_account" "my_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.my_rg.name
  location                 = azurerm_resource_group.my_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  kind                     = "StorageV2"
  enable_https_traffic_only = true
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}
resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.my_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = var.index_file_path
  content_type           = "text/html"
}
resource "azurerm_storage_blob" "error_html" {
  name                   = "404.html"
  storage_account_name   = azurerm_storage_account.my_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = var.error_file_path
  content_type           = "text/html"
}
output "static_website_url" {
  value = azurerm_storage_account.my_storage.primary_web_endpoint
}