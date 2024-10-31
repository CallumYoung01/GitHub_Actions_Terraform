# Create a Container App Environment
resource "azurerm_container_app_environment" "example" {
  name                = "cae-tf-test"
  resource_group_name = "Manual-cae-test"
  location            = var.location
  infrastructure_subnet_id = data.azurerm_subnet.this.id
  internal_load_balancer_enabled = true
  # No internal or vnet_configuration here
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