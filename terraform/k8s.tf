resource "digitalocean_kubernetes_cluster" "cluster_1" {
  name    = "simplistic-production-1"
  region  = "ams3"
  version = "1.14.1-do.4"

  node_pool {
    name       = "default"
    size       = "s-1vcpu-2gb"
    node_count = 1
  }
}
