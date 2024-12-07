variable "storage_account_name" {
  description = "The name of the storage account"
}

variable "backend_resource_group_name" {
  description = "The resource group for the storage account used in the Terraform backend"
}

variable "backend_storage_account_name" {
  description = "The name of the storage account used in the Terraform backend"
}

variable "backend_container_name" {
  description = "The container name where the state file will be stored"
}

variable "backend_key" {
  description = "The key for the Terraform state file"
}