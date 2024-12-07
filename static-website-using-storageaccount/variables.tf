variable "location" {
  description = "Azure region for the resources"
  default     = "centralindia"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-static-website"
}
variable "storage_account_name" {
  description = "Globally unique name for the storage account"
  default     = "rishavstoragebucket"
}
variable "index_file_path" {
  description = "Path to the index.html file"
  default     = "./index.html"
}
variable "error_file_path" {
  description = "Path to the 404.html file"
  default     = "./404.html"
}
