# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "main_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subnet for Web and DB
resource "azurerm_subnet" "web_subnet" {
  name                 = var.web_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = [var.web_subnet_cidr]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = [var.db_subnet_cidr]
}

# Network Security Group for Web
resource "azurerm_network_security_group" "web_sg" {
  name                = "web-sg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-web-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "80"
    source_address_prefix     = "*"
    destination_address_prefix = "*"
  }
}

# Network Security Group for DB
resource "azurerm_network_security_group" "db_sg" {
  name                = "db-sg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-db-mysql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                  = "Tcp"
    source_port_range         = "*"
    destination_port_range    = "3306"
    source_address_prefix     = var.web_subnet_cidr
    destination_address_prefix = "*"
  }
}

# Virtual Machine for Web Tier
resource "azurerm_linux_virtual_machine" "web_vm" {
  name                            = var.web_vm_name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = var.web_vm_size
  admin_username                  = var.web_vm_admin_username
  admin_password                  = var.web_vm_admin_password
  network_interface_ids           = [azurerm_network_interface.web_nic.id]
  availability_set_id             = azurerm_availability_set.web_availability_set.id
  custom_data                     = file("scripts/setup-web.sh")

  depends_on = [azurerm_network_security_group.web_sg]
}

# Network Interface for Web VM
resource "azurerm_network_interface" "web_nic" {
  name                            = "web-nic"
  location                        = azurerm_resource_group.main.location
  resource_group_name             = azurerm_resource_group.main.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [azurerm_network_security_group.web_sg]
}

# Availability Set for Web VM
resource "azurerm_availability_set" "web_availability_set" {
  name                         = "web-avail-set"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  managed                      = true
}

# MySQL Database on Azure
resource "azurerm_mysql_server" "db_server" {
  name                         = var.db_server_name
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "5.7"
  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  sku_name                     = var.db_sku
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
}

# MySQL Database
resource "azurerm_mysql_database" "db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_mysql_server.db_server.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}
