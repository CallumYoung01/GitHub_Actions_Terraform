

#resource "azurerm_container_app_environment" "example" {
#  name                       = "my-environment"
#  location                   = var.location
#  resource_group_name        = azurerm_resource_group.main_rg.name
#  #log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
#}

resource "azurerm_app_service_environment" "managed_environment" {
    name                = "tf-created-cae"
    resource_group_name = azurerm_resource_group.main_rg.name
    location            = var.location

  #zone_redundant = false 
    subnet_id = data.azurerm_subnet.this.id

  #infrastructure_resource_group = "ME_managedEnvironment-tf"
  #infrastructure_subnet_id   = data.azurerm_subnet.this.id


  #vnet_configuration {
  #  internal                   = true
  #  infrastructure_subnet_id   = data.azurerm_subnet.this.id
  #}

  #peer_authentication {
  #  mtls {
  #    enabled = false
  #  }
  #}

  #peer_traffic_configuration {
  #  encryption {
  #    enabled = false
  #  }
  #}

    workload_profile {
        workload_profile_type = "Consumption"
        name                  = "Consumption"
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