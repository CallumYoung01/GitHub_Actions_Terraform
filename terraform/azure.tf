
terraform {
  backend "azurerm" {
    key                  = "github.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}



#terraform {
#
#  backend "azurerm" {
#    key                  = "github.terraform.tfstate"
#  }
#
#  required_version = ">=0.12"
#
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "~>4.7.6"
#    }
#  }
#}
#
###
## Providers
###
#
#provider "azurerm" {
#  features {}
#}
#
#
#
#terraform {
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "~>3.54"
#    }
#    azuread = {
#      source  = "hashicorp/azuread"
#      version = "~>2.43"
#    }
#  }
#
#  backend "azurerm" {}
#}
#
#provider "azurerm" {
#  features {
#    resource_group {
#      prevent_deletion_if_contains_resources = false
#    }
#  }
#  alias           = "sub"
#  subscription_id = var.subscription_id
#}