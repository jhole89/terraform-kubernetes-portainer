variable "http_port" {
  type        = number
  description = "LoadBalancer HTTP port."
  default     = 9000
}

variable "edge_port" {
  type        = number
  description = "Agent EDGE port."
  default     = 8000
}

variable "image" {
  type        = string
  description = "Docker image."
  default     = "portainer/portainer-k8s-beta:linux-amd64"
}

variable "name" {
  type        = string
  description = "App name to be used for namespace, service, and deployment."
  default     = "portainer"
}

variable "labels" {
  type        = map(string)
  description = "App labels to be used for namespace, service, and deployment."
  default     = {}
}
