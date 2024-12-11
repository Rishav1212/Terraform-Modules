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
    subscription_id = "6fe992c9-7dc9-4ead-b082-3c940494b3b1"
    features {}
  }