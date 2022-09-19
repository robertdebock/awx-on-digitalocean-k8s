# Find kubernetes versions.
data "digitalocean_kubernetes_versions" "default" {}

# Create a K8s cluster.
resource "digitalocean_kubernetes_cluster" "default" {
  name    = "robert"
  region  = "ams3"
  version = data.digitalocean_kubernetes_versions.default.latest_version
  ha      = true

  node_pool {
    name       = "default-pool"
    size       = "s-4vcpu-8gb-intel"
    node_count = 3
  }
  maintenance_policy {
    start_time  = "04:00"
    day         = "sunday"
  }
}

# Save the configuration for kubectl and helm.
resource "local_file" "default" {
  content  = digitalocean_kubernetes_cluster.default.kube_config[0].raw_config
  filename = "kube_config.yaml"
  file_permission = "0400"
}

# Deploy the AWX operator.
resource "helm_release" "default" {
  name       = "my-awx-operator"
  repository = "https://ansible.github.io/awx-operator/"
  chart      = "awx-operator"
}

# Read the deployment file.
data "kubectl_file_documents" "default" {
    content = file("awx-deployment.yaml")
}

# Deploy AWX
resource "kubectl_manifest" "default" {
    for_each  = data.kubectl_file_documents.default.manifests
    yaml_body = each.value
}