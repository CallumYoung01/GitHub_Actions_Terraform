terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
}

provider "azurerm" {
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
#      version = "~>2.0"
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