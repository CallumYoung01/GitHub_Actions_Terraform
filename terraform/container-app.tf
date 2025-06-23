# Create a Container App with VNet integration
#resource "azurerm_container_app" "example" {
#  name                       = "myContainerApp"
#  container_app_environment_id = azurerm_container_app_environment.example.id
#  resource_group_name        = "Manual-cae-test"
#  location                   = var.location
#  revision_mode = "multiple"  # Set to "single" for only one active revision
#
#
#  # Template block to specify how to run the container
#  template {
#    # Container block to define the container specifications
#    container {
#      name   = "myContainer"  # Name of the container
#      image  = "mcr.microsoft.com/azuredocs/aci-helloworld"  # Your container image
#
#      # Optional: Define environment variables
#      env {
#        name  = "EXAMPLE_ENV_VAR"
#        value = "example value"
#      }
#      memory = "1.0Gi"
#      cpu = "0.5"  
#
#
#    }
## Set the scaling configuration
#      min_replicas = 1         # Minimum replicas
#      max_replicas = 2         # Maximum replicas
#
#    # VNet Configuration
#    #vnet_configuration {
#    #  subnet_id = azurerm_subnet.example.id
#    #}
#  }
#}