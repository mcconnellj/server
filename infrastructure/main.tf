resource "null_resource" "start-cluster" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}

# Needed before apply-yaml because it installs CRDs
resource "helm_release" "argocd" {
  depends_on = [null_resource.start-cluster]
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.2"
  create_namespace = true
  values = [
    <<-EOT
    installCRDs: true
    server:
      extraArgs: 
        - --insecure
    EOT
  ]
}

resource "null_resource" "apply-namespaces" {
  depends_on = [null_resource.start-cluster]
  provisioner "local-exec" {
    command = "kubectl apply -f ../namespace.yaml"
  }
}

resource "null_resource" "apply-yaml" {
  depends_on = [null_resource.start-cluster, null_resource.apply-namespaces, helm_release.argocd]
  provisioner "local-exec" {
    command = "kubectl apply -f ../"
  }
}