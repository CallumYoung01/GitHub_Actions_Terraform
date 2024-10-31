# Create a Container App Environment
resource "azurerm_container_app_environment" "example" {
  name                = "cae-tf-test"
  resource_group_name = "terraform-cae"
  location            = var.location
  infrastructure_subnet_id = data.azurerm_subnet.this.id
  internal_load_balancer_enabled = true
  # No internal or vnet_configuration here
}



data "azurerm_virtual_network" "this" {
    name = "cae-vnet"
    resource_group_name = "terraform-cae"
}

data "azurerm_subnet" "this" {
    name = "cae-subnet"
    resource_group_name = "terraform-cae"
    virtual_network_name = "cae-vnet"
}