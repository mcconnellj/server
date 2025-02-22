resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.11"
  create_namespace = true
  values = [file("../apps/argocd/values.yaml")]
}

resource "kubernetes_manifest" "applicationset" {
  depends_on = [helm_release.argocd]
  manifest = yamldecode(file("../manifests/application-set.yaml"))
}