resource "azurerm_user_assigned_identity" "howestprime-wide-p-mi-keyvaultreader" {
  name                = var.howestprime_azure_resource_names["azurerm_managed_container"]
  location            = var.howestprime_azure_resource_location
  resource_group_name = azurerm_resource_group.howestprime-wide-p-arg.name
}

resource "azurerm_role_assignment" "mi_keyvault_secrets_officer" {
  scope                = azurerm_key_vault.howestprime-wide-p-akv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.howestprime-wide-p-mi-keyvaultreader.principal_id
  depends_on           = [azurerm_role_assignment.terraform-key-vault-admin]
}