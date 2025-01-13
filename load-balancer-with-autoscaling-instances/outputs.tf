output "load_balancer_public_ip" {
  description = "Public IP of the load balancer"
  value       = azurerm_public_ip.lb.ip_address
}
output "vmss_name" {
  description = "Name of the Virtual Machine Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.main.name
}