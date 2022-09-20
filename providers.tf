terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.20.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.5.1"
    }
    time = {
      source = "hashicorp/time"
      version = "0.8.0"
    }
  }
}

provider "digitalocean" {}

provider "kubectl" {
  config_path = local_file.default.filename
}
provider "local" {}

provider "helm" {
  kubernetes {
    config_path = local_file.default.filename
  }
}
