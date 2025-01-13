variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "terraform-lb-asg-rg"
}

variable "location" {
  description = "Azure region"
  default     = "centralindia"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  default     = "rishavr"
}

variable "admin_password" {
  description = "Admin password for the VM"
  default     = "wip_1234"
}

variable "instance_count" {
  description = "Number of VM instances in the scale set"
  default     = 2
}
