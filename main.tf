resource "kubernetes_namespace" "app_namespaces" {
  for_each = { for k, v in var.application-list : v.namespace => v if v.namespace != "default" }

  metadata {
    name = each.key
  }
}

resource "helm_release" "app" {
  for_each = local.application-list-with-defaults

  name                = each.key
  chart               = each.value.chart
  version             = each.value.version
  namespace           = each.value.namespace
  values              = each.value.values

  # Optional parameters now merged with defaults
  atomic              = each.value.atomic
  cleanup_on_fail     = each.value.cleanup_on_fail
  create_namespace    = each.value.create_namespace
  force_update        = each.value.force_update
  recreate_pods       = each.value.recreate_pods
  replace             = each.value.replace
  repository          = each.value.repository
  reset_values        = each.value.reset_values
  reuse_values        = each.value.reuse_values
  skip_crds           = each.value.skip_crds
  timeout             = each.value.timeout
  wait                = each.value.wait
  wait_for_jobs       = each.value.wait_for_jobs

  depends_on = [kubernetes_namespace.app_namespaces]
}


