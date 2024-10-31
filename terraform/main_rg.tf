#resource "azurerm_resource_group" "main_rg" {
#  name     = "rg-${var.product_alias}-${var.environment}"   ## This is the way MS want us to format resources: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/govern/resource-consistency/naming
#  location = var.location
#
#  lifecycle {
#    ignore_changes = [
#      tags
#    ]
#  }
#}