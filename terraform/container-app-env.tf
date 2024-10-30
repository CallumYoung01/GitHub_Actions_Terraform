

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

  zone_redundant = false

  infrastructure_resource_group = "ME_managedEnvironment-tf"

  vnet_configuration {
    internal                   = true
    infrastructure_subnet_id   = azurerm_subnet.manual_subnet_1.id
  }

  peer_authentication {
    mtls {
      enabled = false
    }
  }

  peer_traffic_configuration {
    encryption {
      enabled = false
    }
  }

  workload_profile {
    workload_profile_type = "Consumption"
    name                  = "Consumption"
  }
}