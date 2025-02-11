terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.6"
    }
  }
  cloud {
    organization = "my_org_g1"
    workspaces {
      name = "Hands-On_With_Terraform_On_Azure"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  #subscription_id = "/subscriptions/9bca8b87-463a-46ec-bfa4-892365f5ede3"
}

resource "azurerm_resource_group" "rg" {
   # subscription_id = "/subscriptions/9bca8b87-463a-46ec-bfa4-892365f5ede3"
    name     = "DefaultResourceGroup-EUS2"
    location = "East US 2"
}

module "securestorage" {
  source  = "app.terraform.io/my_org_g1/securestorage/azurerm"
  version = "2.0.0"
  # insert required variables here
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = "g11securestorage"
}
