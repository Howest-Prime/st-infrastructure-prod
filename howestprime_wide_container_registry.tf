resource "azurerm_container_registry" "howestprimewideacr" {
  name                = var.howestprime_azure_resource_names["azurerm_container_registry_howestprime"]
  resource_group_name = azurerm_resource_group.howestprime-wide-p-arg.name
  location            = azurerm_resource_group.howestprime-wide-p-arg.location
  sku                 = "Basic"
  admin_enabled       = false
}