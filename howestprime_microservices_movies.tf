resource "azurerm_postgresql_flexible_server" "howestprime_movies_db_server" {
    name                          = var.howestprime_azure_resource_names["azurerm_movies_db_server"]
    resource_group_name           = azurerm_resource_group.howestprime-wide-p-arg.name
    location                      = azurerm_resource_group.howestprime-wide-p-arg.location
    version                       = "13"
    public_network_access_enabled = true
    administrator_login           = var.howestprime_usernames["movies_db_admin"]
    administrator_password        = random_password.howestprime_random_password_generator.result
    zone                          = "1"
    backup_retention_days         = 7

    storage_mb   = 32768
    storage_tier = "P4"

    sku_name = "B_Standard_B1ms"

    lifecycle {
        ignore_changes = [zone]
    }
}

resource "azurerm_postgresql_flexible_server_database" "howestprime_movies_db" {
    name      = var.howestprime_azure_resource_names["azurerm_movies_db_movies"]
    server_id = azurerm_postgresql_flexible_server.howestprime_movies_db_server.id
    collation = "en_US.utf8"
    charset   = "UTF8"

    depends_on = [
        azurerm_postgresql_flexible_server.howestprime_movies_db_server
    ]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_ranges" {
  for_each = { for rule in var.howestprime_allowed_ip_ranges : rule.name => rule }

  name             = each.value.name
  server_id        = azurerm_postgresql_flexible_server.howestprime_movies_db_server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address

  depends_on = []
}

resource "azurerm_key_vault_secret" "azurerm_key_vault_secret_movies_db" {
    name         = var.howestprime_azure_resource_names["azurerm_key_vault_secret_movies_db"]
    value        = random_password.howestprime_random_password_generator.result
    key_vault_id = azurerm_key_vault.howestprime-wide-p-akv.id
    depends_on = [
        azurerm_postgresql_flexible_server.howestprime_movies_db_server,
        azurerm_postgresql_flexible_server_database.howestprime_movies_db,
        azurerm_role_assignment.terraform-key-vault-admin
    ]
}

locals {
  dotnet_connection_string = format(
    "Server=%s;Database=movies;Port=%s;User Id={username};Password={password};Ssl Mode=Require;",
    azurerm_postgresql_flexible_server.howestprime_movies_db_server.fqdn,
    5432
  )

  messagebroker_password_uri = regex("(https://[^/]+/secrets/[^/]+)",
    azurerm_key_vault_secret.CLOUDAMQP_instance_secret.id)[0]

  psql_password_uri = regex("(https://[^/]+/secrets/[^/]+)",
    azurerm_key_vault_secret.azurerm_key_vault_secret_movies_db.id)[0]

  howestprime-movies-gh-action-variables = {
    howestprime_movies_p_psql_login = {
      variable_name = "howestprime_movies_p_psql_login"
      value         = var.howestprime_usernames["movies_db_admin"]
    }
    howestprime_movies_p_psql_connection_string = {
      variable_name = "howestprime_movies_p_psql_connection_string"
      value         = local.dotnet_connection_string
    }
    howestprime_wide_messagebroker_login = {
      variable_name = "howestprime_wide_p_messagebroker_login"
      value         = data.cloudamqp_credentials.local-admin.username
    }
    howestprime_wide_keyvault_uri = {
      variable_name = "howestprime_wide_p_keyvault_uri"
      value         = azurerm_key_vault.howestprime-wide-p-akv.vault_uri
    }
    howestprime_wide_mi_keyvaultreader_uri = {
      variable_name = "howestprime_wide_mi_keyvaultreader_uri"
      value         = azurerm_user_assigned_identity.howestprime-wide-p-mi-keyvaultreader.id
    }
    az_tenant_id = {
      variable_name = "az_tenant_id"
      value         = var.howestprime_tenant_id
    }
    az_subscription_id = {
      variable_name = "az_subscription_id"
      value         = var.howestprime_subscription_id
    }
    az_resource_group = {
      variable_name = "az_resource_group"
      value         = azurerm_resource_group.howestprime-wide-p-arg.name
    }
    az_container_registry = {
      variable_name = "az_container_registry"
      value         = azurerm_container_registry.howestprimewideacr.login_server
    }
    az_container_environment = {
      variable_name = "az_container_environment"
      value         = azurerm_container_app_environment.howestprime-wide-p-ace.name
    }
    howestprime_movies_p_sqlsrv_password_uri = {
      variable_name = "howestprime_movies_p_sqlsrv_password_uri"
      value         = local.psql_password_uri
    }
    howestprime_wide_p_messagebroker_password_uri = {
      variable_name = "howestprime_wide_p_messagebroker_password_uri"
      value         = local.messagebroker_password_uri
    }
    howestprime_wide_p_messagebroker_hostname = {
      variable_name = "howestprime_wide_p_messagebroker_hostname"
      value         = cloudamqp_instance.howestprime_cloudamqp_instance.host
    }
    howestprime_wide_p_messagebroker_vhost = {
      variable_name = "howestprime_wide_p_messagebroker_vhost"
      value         = cloudamqp_instance.howestprime_cloudamqp_instance.vhost
    }
  }

  howestprime-movies-gh-action-secrets = {
    howestprime_wide_ci_service_principal = {
      secret_name = "howestprime_wide_ci_service_principal"
      value       = azuread_application.github_ci_cd_app.client_id
    }
    howestprime_wide_ci_service_principal_password = {
      secret_name = "howestprime_wide_ci_service_principal_password"
      value       = azuread_application_password.github_ci_cd_secret.value
    }
  }
}

resource "github_actions_variable" "howestprime_movies" {
  for_each      = local.howestprime-movies-gh-action-variables
  repository    = var.howestprime_github_movies_repository
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_actions_secret" "howestprime_movies" {
  for_each        = local.howestprime-movies-gh-action-secrets
  repository      = var.howestprime_github_movies_repository
  secret_name     = each.value.secret_name
  plaintext_value = each.value.value
}
