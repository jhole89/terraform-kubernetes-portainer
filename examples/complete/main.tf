provider "kubernetes" {
  config_path = var.kubeconf_path

  config_context_auth_info = var.config_user
  config_context_cluster   = var.cluster_name
}

module "portainer" {
  source       = "./../../"
  name         = "my-portainer"
  service_type = "NodePort"
  edge_port    = 8001
  http_port    = 9001
  labels = {
    terraform = "true"
  }
  storage_class = "standard"
  storage_size  = "128Mi"
}
