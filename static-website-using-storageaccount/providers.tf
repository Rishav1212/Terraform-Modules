terraform {
    required_version = "= 4.4.0"
  
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
  }
  
  provider "azurerm" {
    features {}
  }
  