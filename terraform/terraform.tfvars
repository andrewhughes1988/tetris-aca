resource_group_name = "tetris-aca"
location            = "centralus"
workspace_name      = "netsysprep-tetris-workspace"
environment_name    = "cae-netsysprep-tetris"
container_app_name  = "tetris"
container_image     = "index.docker.io/andrewhughes1988/tetris:1.0"
target_port         = 80

# Registry configurations (optional, leave empty if pulling public images anonymously)
registry_server   = ""
registry_username = ""
registry_password = ""

# Alert contact (optional, leave empty to disable email alerts)
alert_email = "andrew.hughes@netsysprep.com"

tags = {
  Environment = "PROD"
  ManagedBy   = "Terraform"
}

# Cloudflare configurations
cloudflare_zone_id = "dcf36ded33f26dcf9bf562d0e00fc0e8"
subdomain          = "tetris"
custom_domain      = "tetris.netsysprep.com"

transport_method = "auto"