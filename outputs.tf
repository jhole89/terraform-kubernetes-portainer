output "ingress" {
  value = kubernetes_service.portainer.load_balancer_ingress
}

output "service_url" {
  value = kubernetes_service.portainer.metadata.0.self_link
}

output "service_version" {
  value = kubernetes_service.portainer.metadata.0.resource_version
}

output "namespace" {
  value = kubernetes_namespace.portainer.metadata.0.name
}

output "service_name" {
  value = kubernetes_service.portainer.metadata.0.name
}

output "crb_name" {
  value = kubernetes_cluster_role_binding.portainer.metadata.0.name
}

output "deployment_name" {
  value = kubernetes_deployment.portainer.metadata.0.name
}

output "pvc_name" {
  value = kubernetes_persistent_volume_claim.portainer.metadata.0.name
}

output "service_account_name" {
  value = kubernetes_service_account.portainer.metadata.0.name
}
