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