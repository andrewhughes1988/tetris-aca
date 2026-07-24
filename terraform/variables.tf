variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group to create or use"
  default     = "ACA"
}

variable "location" {
  type        = string
  description = "The Azure Region to deploy resources into"
  default     = "centralus"
}

variable "workspace_name" {
  type        = string
  description = "The name of the Log Analytics Workspace"
  default     = "workspaceaca9c6d"
}

variable "environment_name" {
  type        = string
  description = "The name of the Container App Environment"
  default     = "managedEnvironment-ACA-81fa"
}

variable "container_app_name" {
  type        = string
  description = "The name of the Container App"
  default     = "openspeedtest"
}

variable "container_image" {
  type        = string
  description = "The container image to deploy"
  default     = "index.docker.io/openspeedtest/latest:latest"
}

variable "target_port" {
  type        = number
  description = "The port the container is listening on"
  default     = 80
}

variable "registry_server" {
  type        = string
  description = "The container registry server"
  default     = ""
}

variable "registry_username" {
  type        = string
  description = "The container registry username"
  default     = ""
}

variable "registry_password" {
  type        = string
  description = "The container registry password"
  default     = ""
  sensitive   = true
}

variable "alert_email" {
  type        = string
  description = "Email address to receive alerts"
  default     = "andrew.hughes@netsysprep.com"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
  default     = {}
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with DNS Edit permissions"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Zone ID of your domain in Cloudflare"
}

variable "subdomain" {
  type        = string
  description = "The subdomain for the app (e.g. speedtest)"
  default     = "openspeedtest"
}

variable "custom_domain" {
  type        = string
  description = "The full custom domain FQDN (e.g. speedtest.yourdomain.com)"
}


variable "transport_method" {
  type        = string
  description = "Ingress transport method: auto, http, http2, tcp"
  default     = "auto"
}