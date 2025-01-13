# Location
variable "location" {
  description = "Azure region where resources will be deployed"
  default     = "centralindia"
}

# Dev Resource Group Name
variable "dev_resource_group_name" {
  description = "Name of the Dev resource group"
  default     = "dev-rg"
}

# QA Resource Group Name
variable "qa_resource_group_name" {
  description = "Name of the QA resource group"
  default     = "qa-rg"
}

# Virtual Machine Size
variable "vm_size" {
  description = "Size of the virtual machines"
  default     = "Standard_DS1_v2"
}

# Admin Username
variable "admin_username" {
  description = "Admin username for the virtual machines"
  default     = "adminuser"
}

# Admin Password
variable "admin_password" {
  description = "Admin password for the virtual machines"
}

# Number of VMs
variable "instance_count" {
  description = "Number of virtual machines in each environment"
  default     = 2
}
