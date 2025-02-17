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

# Install ArgoCD using Helm (skip CRD installation)
resource "helm_release" "argo_cd" {
  name       = "my-argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.2"
  
  # Disable the installation of CRDs, as they already exist
  set {
    name  = "installCRDs"
    value = "false"
  }

  depends_on = [null_resource.minikube_start]  # Ensures Minikube starts first
}

# Expose ArgoCD via port-forward to localhost (to make it accessible)
resource "null_resource" "argocd_port_forward" {
  provisioner "local-exec" {
    command = "kubectl port-forward svc/argocd-server -n argocd 8080:443"
  }

  depends_on = [helm_release.argo_cd]
}
