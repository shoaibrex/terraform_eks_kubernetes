# Configure Kubernetes Provider using EKS cluster info
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.my_cluster.token
}

data "aws_eks_cluster_auth" "my_cluster" {
  name = module.eks.cluster_name
}

# Create a namespace
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "html-app"
  }
}

# Deploy HTML/JavaScript using Nginx
resource "kubernetes_deployment" "html_app" {
  metadata {
    name      = "html-deployment"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "html-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "html-app"
        }
      }

      spec {
        container {
          image = "shbrafi/html-app:latest"
          name  = "html-app"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Expose the app using a LoadBalancer service
resource "kubernetes_service" "html_app_service" {
  metadata {
    name      = "html-app-service"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "html-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
