resource "azurerm_resource_group" "my_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "my_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.my_rg.name
  location                 = azurerm_resource_group.my_rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_virtual_machine" "my_vm" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.my_rg.name
  location              = azurerm_resource_group.my_rg.location
  network_interface_ids = [var.network_interface_id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}