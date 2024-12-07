variable "resource_group_name" {
  description = "Name of the Resource Group"
  default     = "rg-static-website"
}

variable "location" {
  description = "Azure location for the resources"
  default     = "centralindia"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  default     = "static-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  default     = "10.0.0.0/12"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  default     = "static-subnet"
}

variable "subnet_address_prefix" {
  description = "Address prefix for the Subnet"
  default     = "10.0.1.0/24"
}