
#resource "azurerm_resource_group" "example" {
#  name     = "example-resources"
#  location = "West Europe"
#}
#
#resource "azurerm_virtual_network" "example" {
#  name                = "example-vnet"
#  address_space       = ["10.0.0.0/16"]
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#}
#
#resource "azurerm_subnet" "integration" {
#  name                 = "integration-subnet"
#  resource_group_name  = azurerm_resource_group.example.name
#  virtual_network_name = azurerm_virtual_network.example.name
#  address_prefixes     = ["10.0.1.0/24"]
#  delegation {
#    name = "delegation"
#    service_delegation {
#      name = "Microsoft.Web/serverFarms"
#    }
#  }
#}
#
#resource "azurerm_subnet" "endpoint" {
#  name                 = "endpoint-subnet"
#  resource_group_name  = azurerm_resource_group.example.name
#  virtual_network_name = azurerm_virtual_network.example.name
#  address_prefixes     = ["10.0.2.0/24"]
#  private_endpoint_network_policies_enabled = true
#}
#
#resource "azurerm_app_service_plan" "example" {
#  name                = "example-appserviceplan"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  kind                = "Linux"
#  reserved            = true
#  sku {
#    tier = "PremiumV2"
#    size = "P1v2"
#  }
#}
#
#resource "azurerm_app_service" "example" {
#  name                = "example-appservice"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  app_service_plan_id = azurerm_app_service_plan.example.id
#  site_config {
#    linux_fx_version = "DOCKER|nginx:latest"
#  }
#}
#
#resource "azurerm_private_endpoint" "example" {
#  name                = "example-private-endpoint"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  subnet_id           = azurerm_subnet.endpoint.id
#  private_service_connection {
#    name                           = "example-privateserviceconnection"
#    private_connection_resource_id = azurerm_app_service.example.id
#    subresource_names              = ["sites"]
#    is_manual_connection           = false
#  }
#}
#
#resource "azurerm_private_dns_zone" "example" {
#  name                = "privatelink.azurewebsites.net"
#  resource_group_name = azurerm_resource_group.example.name
#}
#
#data "azurerm_private_endpoint" "example" {
#  name                = azurerm_private_endpoint.example.name
#  resource_group_name = azurerm_resource_group.example.name
#}
#
#resource "azurerm_private_dns_a_record" "example" {
#  name                = azurerm_app_service.example.name
#  zone_name           = azurerm_private_dns_zone.example.name
#  resource_group_name = azurerm_resource_group.example.name
#  ttl                 = 300
#  records             = [data.azurerm_private_endpoint.example.private_service_connection[0].private_ip_address]
#}
#
#resource "azurerm_private_dns_zone_virtual_network_link" "example" {
#  name                  = "example-dnslink"
#  resource_group_name   = azurerm_resource_group.example.name
#  private_dns_zone_name = azurerm_private_dns_zone.example.name
#  virtual_network_id    = azurerm_virtual_network.example.id
#}
#