data "azuread_client_config" "current" {}

resource "azuread_application" "github_ci_cd_app" {
  display_name = "github-ci-cd-build-pipeline-app"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "time_rotating" "github_sp_rotation" {
  rotation_days = 180
}

resource "azuread_service_principal" "github_ci_cd_sp" {
  client_id = azuread_application.github_ci_cd_app.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "github_ci_cd_secret" {
  application_id = azuread_application.github_ci_cd_app.id
  display_name   = "github-ci-cd-secret"

  rotate_when_changed = {
    rotation = time_rotating.github_sp_rotation.id
  }

  depends_on = [
    azuread_service_principal.github_ci_cd_sp
  ]
}

resource "azurerm_role_assignment" "github_container_registry_push_access" {
  role_definition_name = "AcrPush"
  scope                = azurerm_container_registry.howestprimewideacr.id
  principal_id         = azuread_service_principal.github_ci_cd_sp.object_id
  depends_on           = [azurerm_key_vault.howestprime-wide-p-akv]
}

resource "azurerm_role_assignment" "github_resource_group_contributor" {
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.howestprime-wide-p-arg.id
  principal_id         = azuread_service_principal.github_ci_cd_sp.object_id
  depends_on           = [azurerm_key_vault.howestprime-wide-p-akv]
}