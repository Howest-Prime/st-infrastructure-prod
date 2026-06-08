resource "azurerm_service_plan" "howestprime_client_webapp_service_plan" {
  name                = var.howestprime_azure_resource_names.azurerm_client_webapp_service_plan
  resource_group_name = azurerm_resource_group.howestprime-wide-p-arg.name
  location            = azurerm_resource_group.howestprime-wide-p-arg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "howestprime_client_webapp" {
  name                = var.howestprime_azure_resource_names.azurerm_client_webapp_web_app
  resource_group_name = azurerm_resource_group.howestprime-wide-p-arg.name
  location            = azurerm_resource_group.howestprime-wide-p-arg.location
  service_plan_id     = azurerm_service_plan.howestprime_client_webapp_service_plan.id
  https_only          = true

  site_config {
    always_on           = false
    minimum_tls_version = "1.2"

    application_stack {
      docker_image_name   = "howestprime-client-webapp:latest"
      docker_registry_url = "https://hcr.technet.howest.be"
    }

    cors {
      allowed_origins = ["*"]
    }
  }

  app_settings = {
    DOCKER_REGISTRY_URL                 = "https://hcr.technet.howest.be"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    VITE_APP_TICKETING_API_URL          = var.howestprime_ticketing_api_url
    VITE_APP_MOVIES_BASE_API_URL        = var.howestprime_movies_api_url
  }

  auth_settings {
    enabled = false
  }
}
