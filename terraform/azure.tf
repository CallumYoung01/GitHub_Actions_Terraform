terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.54"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.43"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  alias           = "sub"
  subscription_id = var.subscription_id
}