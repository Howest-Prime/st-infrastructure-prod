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