# Howest Prime Production Infrastructure

This repository defines Howest Prime production resources with Terraform. It provisions shared infrastructure and service-specific resources in Microsoft Azure, integrates with CloudAMQP, and configures GitHub Actions variables and secrets used by the application repositories.

## Managed components

The Terraform configuration includes:

- An Azure resource group, Container Apps environment, Container Registry, Log Analytics workspace, Key Vault, and managed identities.
- A PostgreSQL Flexible Server and database for the Movies service.
- An Azure Cosmos DB account using the MongoDB API for Ticketing.
- A CloudAMQP-managed LavinMQ message broker.
- Linux App Service resources for the web app and backoffice.
- GitHub Actions configuration for the Movies, Ticketing, and backoffice repositories.

The exact resource names and settings are supplied through Terraform variables. Secret values are generated or referenced through the configured secret-management resources.

## Requirements

Terraform and access to the configured Azure subscription, CloudAMQP account, and GitHub organization are required. Provider credentials and required variable values must be supplied through a private local configuration or an approved secrets mechanism. The repository includes a sensitive-variable example file; do not commit populated credentials, Terraform state, or plan files.

Review the Terraform configuration and planned changes with the infrastructure owner before applying. This repository can create, update, or remove cloud resources when Terraform is applied.

## Related repositories

- [Movies microservice](https://github.com/Howest-Prime/st-microservice-movies)
- [Ticketing microservice](https://github.com/Howest-Prime/st-microservice-ticketing)
- [Test infrastructure](https://github.com/Howest-Prime/st-infrastructure-test)
