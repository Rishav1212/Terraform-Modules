terraform {
    required_version = "= 1.10.1"
  
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
  }
  
  provider "azurerm" {
    subscription_id = "3d3c7d87-16fe-426b-8bc0-818b16182fb3"
    features {}
  }