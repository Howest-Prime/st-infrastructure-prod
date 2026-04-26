resource "azurerm_key_vault" "howestprime-wide-p-akv" {
  name                        = var.howestprime_azure_resource_names["azurerm_key_vault_howestprime"]
  location                    = azurerm_resource_group.howestprime-wide-p-arg.location
  resource_group_name         = azurerm_resource_group.howestprime-wide-p-arg.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.howestprime_tenant_id

  rbac_authorization_enabled = true
  
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

resource "azurerm_key_vault_secret" "CLOUDAMQP_instance_secret" {
  name                      = var.howestprime_azure_resource_names["azurerm_cloudamqp_instance_secret"]
  value                     = data.cloudamqp_credentials.local-admin.password
  key_vault_id              = azurerm_key_vault.howestprime-wide-p-akv.id
  depends_on                = [azurerm_role_assignment.mi_keyvault_secrets_officer] 
}