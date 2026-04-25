resource "azurerm_resource_group" "howestprime-wide-p-arg" {
  name     = var.howestprime_azure_resource_names["azurerm_resource_group_howestprime"]
  location = var.howestprime_azure_resource_location
}