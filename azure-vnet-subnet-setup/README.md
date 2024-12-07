# Azure Infrastructure Setup with Terraform

This repository contains Terraform configurations to create and manage Azure infrastructure, including:

- A Resource Group
- A Virtual Network (VNet)
- A Subnet within the VNet

## Project Structure

- `provider.tf`: Configures the Azure provider.
- `main.tf`: Contains resource definitions for the Resource Group, VNet, and Subnet.
- `variables.tf`: Defines input variables for resource customization.
- `terraform.tfvars`: Provides default values for the variables.
