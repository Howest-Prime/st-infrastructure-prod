resource "azurerm_key_vault" "howestprime-wide-p-akv" {
  name                        = var.howestprime_azure_resource_names["azurerm_key_vault_howestprime"]
  location                    = azurerm_resource_group.howestprime-wide-p-arg.location
  resource_group_name         = azurerm_resource_group.howestprime-wide-p-arg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.howestprime_tenant_id
  
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  
  enabled_for_deployment      = true
  enabled_for_template_deployment = true

  sku_name = "standard"
}

resource "azurerm_role_assignment" "terraform-key-vault-admin" {
    scope                   = azurerm_key_vault.howestprime-wide-p-akv.id
    role_definition_name    = "Key Vault Administrator"
    principal_id            = var.service_principal_terraform_sp_id
    depends_on              = [azurerm_key_vault.howestprime-wide-p-akv]
}