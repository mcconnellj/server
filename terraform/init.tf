provider "local" {}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Ensure Minikube's kubeconfig is in this location
  }
}

# Start Minikube
resource "null_resource" "minikube_start" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}

# Add the Argo Helm repository
resource "helm_repository" "argo_repo" {
  name = "argo"
  url  = "https://argoproj.github.io/argo-helm"
}

# Install ArgoCD using Helm
resource "helm_release" "argo_cd" {
  name       = "my-argo-cd"
  repository = helm_repository.argo_repo.name
  chart      = "argo-cd"
  version    = "7.8.2"

  depends_on = [null_resource.minikube_start]  # Ensures Minikube starts first
}

# Expose ArgoCD via port-forward to localhost (to make it accessible)
resource "null_resource" "argocd_port_forward" {
  provisioner "local-exec" {
    command = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
    environment = {
      KUBEVIRT_KUBEVIRT_VERSION = "v0.38.0"
    }
  }

  depends_on = [helm_release.argo_cd]
}
