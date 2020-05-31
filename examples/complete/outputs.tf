output "ingress" {
  value = module.portainer.ingress
}

output "service_url" {
  value = module.portainer.service_url
}

output "namespace" {
  value = module.portainer.namespace
}

output "service_name" {
  value = module.portainer.service_name
}

output "crb_name" {
  value = module.portainer.crb_name
}

output "deployment_name" {
  value = module.portainer.deployment_name
}

output "pvc_name" {
  value = module.portainer.pvc_name
}

output "service_account_name" {
  value = module.portainer.service_account_name
}

output "service_version" {
  value = module.portainer.service_version
}