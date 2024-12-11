output "resource_group_name" {
  value = azurerm_resource_group.my_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.my_storage.name
}

output "virtual_machine_name" {
  value = azurerm_virtual_machine.my_vm.name
}