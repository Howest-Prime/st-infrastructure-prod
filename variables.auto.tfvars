howestprime_azure_resource_location = "France Central"

howestprime_azure_resource_names = {
  azurerm_resource_group_howestprime = "howestprime-wide-p-arg"
  azurerm_key_vault_howestprime       = "howestprime-wide-p-akv-d"
  azurerm_container_registry_howestprime = "wideacrhowestprime"
  azurerm_cloudamqp_instance_secret   = "cloudamqp-message-broker-instance-secret"
  azurerm_log_analytics_workspace               = "howestprime-wide-p-law"
  azurerm_container_enviroment              = "howestprime-wide-p-ace"
  azurerm_managed_container = "howestprime-wide-p-mi-keyvaultreader"

  azurerm_movies_db_server = "howestprime-movies-p-dbs"
  azurerm_movies_db_movies = "movies"

  azurerm_ticketing_cosmos_db_acc = "howestprime-ticketing-p-dba"
  azurerm_ticketing_db = "ticketing"

  azurerm_key_vault_secret_movies_db = "movies-db-password"
   azurerm_key_vault_secret_ticketing_db = "ticketing-db-password"

  azurerm_client_backoffice_service_plan = "client-backoffice-service-plan"
  azurerm_client_backoffice_web_app = "client-backoffice-web-app"

  azurerm_client_webapp_service_plan = "client-webapp-service-plan"
  azurerm_client_webapp_web_app = "client-webapp-web-app"
}

howestprime_cloudamqp_resource_names = {
  message_broker_name_howestprime = "cloudamqp"
}

howestprime_usernames = {
  movies_db_admin = "howestprime_movies_db"
}

howestprime_allowed_ip_ranges = [
  {
    name             = "allow_all"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "255.255.255.255"
  }
]

howestprime_github_organisation       = "Howest-TI-Project-BnD"
howestprime_github_movies_repository  = "st-microservice-movies-sumanadhikari-howest-1"
howestprime_github_backoffice_repository = "st-client-backoffice-sumanadhikari-howest"
howestprime_github_ticketing_repository  = "st-microservice-ticketing-sumanadhikari-howest"

howestprime_ticketing_api_url = ""
howestprime_movies_api_url    = "https://microservice-movies.icydesert-128767c2.francecentral.azurecontainerapps.io/"



