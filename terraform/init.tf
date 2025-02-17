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

# Install ArgoCD using Helm (directly using the repository URL)
resource "helm_release" "argo_cd" {
  name       = "my-argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
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
