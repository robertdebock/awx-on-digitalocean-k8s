# Create a K8s cluster.
resource "digitalocean_kubernetes_cluster" "default" {
  name    = "robert"
  region  = "ams3"
  version = "1.22.8-do.1"
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
