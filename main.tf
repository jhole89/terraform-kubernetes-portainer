locals {
  labels = merge({ app = "app-${var.name}" }, var.labels)
}

resource "kubernetes_namespace" "portainer" {
  metadata {
    name = var.name
  }
}

resource "kubernetes_service_account" "portainer" {
  metadata {
    name      = "${var.name}-sa-clusteradmin"
    namespace = kubernetes_namespace.portainer.metadata.0.name
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "portainer" {
  metadata {
    name = "${var.name}-crb-clusteradmin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.portainer.metadata.0.name
    namespace = kubernetes_namespace.portainer.metadata.0.name
  }
}

resource "kubernetes_persistent_volume_claim" "portainer" {
  metadata {
    name = "${var.name}-pvc"
    namespace = kubernetes_namespace.portainer.metadata.0.name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = var.storage_class
    resources {
      requests = {
        storage = var.storage_size
      }
    }
  }
}

resource "kubernetes_deployment" "portainer" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.portainer.metadata.0.name
  }
  spec {
    selector {
      match_labels = local.labels
    }
    template {
      metadata {
        labels = local.labels
      }
      spec {
        service_account_name = kubernetes_service_account.portainer.metadata.0.name
        container {
          name              = var.name
          image             = "portainer/portainer-k8s-beta:linux-amd64"
          image_pull_policy = "Always"
          port {
            name           = "edge"
            protocol       = "TCP"
            container_port = 8000
          }
          port {
            name           = "http"
            protocol       = "TCP"
            container_port = 9000
          }
          volume_mount {
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            name       = kubernetes_service_account.portainer.default_secret_name
            read_only  = true
          }
          volume_mount {
            mount_path = "/data"
            name = "data"
            read_only = false
          }
        }
        volume {
          name = kubernetes_service_account.portainer.default_secret_name
          secret {
            secret_name = kubernetes_service_account.portainer.default_secret_name
          }
        }
        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.portainer.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "portainer" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.portainer.metadata.0.name
  }
  spec {
    type     = "LoadBalancer"
    selector = kubernetes_deployment.portainer.spec.0.selector.0.match_labels
    port {
      name        = "edge"
      protocol    = kubernetes_deployment.portainer.spec.0.template.0.spec.0.container.0.port.0.protocol
      port        = var.edge_port
      target_port = kubernetes_deployment.portainer.spec.0.template.0.spec.0.container.0.port.0.container_port
    }
    port {
      name        = "http"
      protocol    = kubernetes_deployment.portainer.spec.0.template.0.spec.0.container.0.port.1.protocol
      port        = var.http_port
      target_port = kubernetes_deployment.portainer.spec.0.template.0.spec.0.container.0.port.1.container_port
    }
  }
}
