resource "azurerm_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}