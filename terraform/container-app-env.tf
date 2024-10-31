

#resource "azurerm_container_app_environment" "example" {
#  name                       = "my-environment"
#  location                   = var.location
#  resource_group_name        = azurerm_resource_group.main_rg.name
#  #log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
#}

resource "azurerm_container_app_environment" "example" {
  name                = "test-tf-cae"
  resource_group_name = "Manual-cae-test"
  location            = var.location
  internal           = true

  # Set the VNet configuration
  vnet_configuration {
    subnet_id = azurerm_subnet.example.id
  }
  
}

data "azurerm_virtual_network" "this" {
    name = "manutal-vnet-1"
    resource_group_name = "Manual-cae-test"
}

data "azurerm_subnet" "this" {
    name = "manual-subnet-1"
    resource_group_name = "Manual-cae-test"
    virtual_network_name = "manutal-vnet-1"
}