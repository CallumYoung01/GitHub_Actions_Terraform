variable "location" {}
variable "product_alias" {}
variable "environment" {}
variable "subscription_id" {}

// ...existing code...
variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID where resources will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
}

variable "app_service_plan_name" {
  type        = string
  description = "The name of the Azure App Service Plan."
}

variable "web_app_name" {
  type        = string
  description = "The name of the Azure Web App."
}

variable "sku_name" {
  type        = string
  description = "The SKU name for the App Service Plan."
}

variable "app_service_plan_tier" {
  type        = string
  description = "The pricing tier for the App Service Plan."
}
