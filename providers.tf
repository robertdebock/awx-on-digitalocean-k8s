terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.20.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "digitalocean" {}

provider "local" {}

provider "helm" {
  kubernetes {
    config_path = local_file.default.filename
  }
}
