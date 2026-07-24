resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "log_analytics" {
  source              = "git::https://github.com/andrewhughes1988/terraform-aca-with-managed-cert.git//modules/log_analytics"
  workspace_name      = var.workspace_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
}

module "container_app" {
  source                     = "git::https://github.com/andrewhughes1988/terraform-aca-with-managed-cert.git//modules/container_app"
  environment_name           = var.environment_name
  container_app_name         = var.container_app_name
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  container_image            = var.container_image
  target_port                = var.target_port
  registry_server            = var.registry_server
  registry_username          = var.registry_username
  registry_password          = var.registry_password
  alert_email                = var.alert_email
  tags                       = var.tags
  transport_method           = var.transport_method
}

module "network" {
  source              = "git::https://github.com/andrewhughes1988/terraform-aca-with-managed-cert.git//modules/network"
  route_table_name    = "rt"
  route_name          = "rter"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
}

# 1. Create the TXT verification record on Cloudflare to prove domain ownership
resource "cloudflare_record" "azure_verify" {
  zone_id = var.cloudflare_zone_id
  name    = "asuid.${var.subdomain}"
  type    = "TXT"
  content = module.container_app.custom_domain_verification_id
  ttl     = 3600
}

# 2. Create the CNAME record pointing to the Container App (non-proxied for validation)
resource "cloudflare_record" "app_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.subdomain
  type    = "CNAME"
  content = module.container_app.container_app_url
  ttl     = 3600
  proxied = false
}

# 3. Wait 30 seconds for Cloudflare DNS propagation
resource "time_sleep" "wait_for_dns" {
  create_duration = "30s"

  depends_on = [
    cloudflare_record.azure_verify,
    cloudflare_record.app_cname
  ]
}

# 4. Bind the custom domain to the Container App (Azure automatically creates and binds the managed certificate)
resource "azurerm_container_app_custom_domain" "domain_binding" {
  container_app_id = module.container_app.container_app_id
  name             = var.custom_domain

  lifecycle {
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }

  depends_on = [
    time_sleep.wait_for_dns
  ]
}

