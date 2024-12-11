variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location for the resources."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "The tier of the storage account."
  type        = string
}

variable "storage_account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine."
  type        = string
}

variable "network_interface_id" {
  description = "The network interface ID for the VM."
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the image."
  type        = string
}

variable "image_offer" {
  description = "The offer of the image."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image."
  type        = string
}

variable "image_version" {
  description = "The version of the image."
  type        = string
}
