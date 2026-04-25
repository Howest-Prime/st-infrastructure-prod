resource "azurerm_log_analytics_workspace" "howestprime-wide-p-law" {
  name                = var.howestprime_azure_resource_names.azurerm_log_analytics_workspace
  location            = var.howestprime_azure_resource_location
  resource_group_name = azurerm_resource_group.howestprime-wide-p-arg.name
}