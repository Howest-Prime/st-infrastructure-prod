resource "azurerm_container_app_environment" "howestprime-wide-p-ace" {
  name                        = var.howestprime_azure_resource_names["azurerm_container_enviroment"]
  location                    = azurerm_resource_group.howestprime-wide-p-arg.location
  resource_group_name         = azurerm_resource_group.howestprime-wide-p-arg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.howestprime-wide-p-law.id
}