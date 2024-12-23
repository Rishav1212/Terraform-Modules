variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "my-resource-group"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "centralindia"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "my-vnet"
}

variable "vnet_cidr" {
  description = "CIDR block for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "web_subnet_name" {
  description = "Name of the web subnet"
  type        = string
  default     = "web-subnet"
}

variable "web_subnet_cidr" {
  description = "CIDR block for the web subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  type        = string
  default     = "db-subnet"
}

variable "db_subnet_cidr" {
  description = "CIDR block for the database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "web_vm_name" {
  description = "Name of the web virtual machine"
  type        = string
}

variable "web_vm_size" {
  description = "Size of the web virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "web_vm_admin_username" {
  description = "Admin username for the web VM"
  type        = string
}

variable "web_vm_admin_password" {
  description = "Admin password for the web VM"
  type        = string
  sensitive   = true
}

variable "db_server_name" {
  description = "Name of the MySQL database server"
  type        = string
}

variable "db_username" {
  description = "Admin username for the database"
  type        = string
}

variable "db_password" {
  description = "Admin password for the database"
  type        = string
  sensitive   = true
}

variable "db_sku" {
  description = "SKU for the MySQL database"
  type        = string
  default     = "B_Gen5_1"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}
