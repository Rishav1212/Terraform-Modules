resource "azurerm_resource_group" "dev" {
  name     = "dev-rg"
  location = "centralindia"
}

resource "azurerm_resource_group" "qa" {
  name     = "qa-rg"
  location = "centralindia"
}

resource "azurerm_virtual_network" "dev" {
  name                = "dev-vnet"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "qa" {
  name                = "qa-vnet"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "dev" {
  name                 = "dev-subnet"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "qa" {
  name                 = "qa-subnet"
  resource_group_name  = azurerm_resource_group.qa.name
  virtual_network_name = azurerm_virtual_network.qa.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "dev" {
  name                = "dev-public-ip"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "qa" {
  name                = "qa-public-ip"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "dev" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "dev-ipconfig"
    subnet_id                     = azurerm_subnet.dev.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev.id
  }
}

resource "azurerm_network_interface" "qa" {
  name                = "qa-nic"
  location            = azurerm_resource_group.qa.location
  resource_group_name = azurerm_resource_group.qa.name

  ip_configuration {
    name                          = "qa-ipconfig"
    subnet_id                     = azurerm_subnet.qa.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.qa.id
  }
}

resource "azurerm_linux_virtual_machine" "dev" {
  count               = 2
  name                = "dev-vm-${count.index}"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  size                = "Standard_DS1_v2"
  admin_username      = "rishav_dev"
  admin_password      = "Wip@dev123"

  network_interface_ids = [
    azurerm_network_interface.dev.id
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_linux_virtual_machine" "qa" {
  count               = 2
  name                = "qa-vm-${count.index}"
  resource_group_name = azurerm_resource_group.qa.name
  location            = azurerm_resource_group.qa.location
  size                = "Standard_DS1_v2"
  admin_username      = "rishav_qa"
  admin_password      = "Wip@qa123"

  network_interface_ids = [
    azurerm_network_interface.qa.id
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
