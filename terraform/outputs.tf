output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the Resource Group"
}

output "log_analytics_workspace_id" {
  value       = module.log_analytics.workspace_id
  description = "The ID of the Log Analytics Workspace"
}

output "container_app_url" {
  value       = module.container_app.container_app_url
  description = "The URL of the deployed container application"
}
