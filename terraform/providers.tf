terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "STORAGE"
    storage_account_name = "netsysprep"
    container_name       = "tetris-tfstate"
    key                  = "tetris.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
