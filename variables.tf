variable "howestprime_subscription_id" {
    type = string
    description = "Azure Subscription ID"
    nullable = false
    sensitive = false
}

variable "howestprime_tenant_id" {
    type = string
    description = "Azure Tenant ID"
    nullable = false
    sensitive = false
}


variable "service_principal_terraform_client_id" {
    type = string
    description = "The client ID of the Terraform service principal"
    nullable = false
    sensitive = true
}

variable "service_principal_terraform_secret" {
    type = string
    description = "The secret of the Terraform service principal"
    nullable = false
    sensitive = true
}

variable "service_principal_terraform_sp_id" {
    type = string
    description = "The Object ID of the Terraform service principal"
    nullable = false
    sensitive = true
}

variable "howestprime_azure_resource_location" {
    type = string
    description = "The Azure location where resources will be deployed"
    nullable = false
    sensitive = false
}

variable "howestprime_azure_resource_names" {
    type = map(string)
    description = "Map of resource names to assign to the resource."
    nullable = true
    sensitive = false
}

variable "howestprime_cloudamqp_customer_api_key" {
    type = string
    description = "CLOUDAMQP API Key"
    nullable = false
    sensitive = true
}

variable "howestprime_cloudamqp_resource_names" {
    type = map(string)
    description = "Map of CloudAMQP resource names"
    nullable = true
    sensitive = false
}

variable "howestprime_usernames" {
    type = map(string)
    description = "Map of usernames"
    nullable = true
    sensitive = false
}

variable "howestprime_allowed_ip_ranges" {
  description = "List allowed IP addresses for documentDB firewall rule"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
}

variable "howestprime_github_token" {
    description = "GitHub personal access token"
    type        = string
    nullable    = false
    sensitive   = true
}

variable "howestprime_github_organisation" {
    description = "GitHub organization or owner name"
    type        = string
    nullable    = false
    sensitive   = true
}

variable "howestprime_github_movies_repository" {
    description = "GitHub repository name for the movies microservice"
    type        = string
    nullable    = false
    sensitive   = false
}

variable "howestprime_github_backoffice_repository" {
    description = "GitHub repository name for the movies microservice"
    type        = string
    nullable    = false
    sensitive   = false
}