# locals.tf

locals {
  # Base directory and values file path
  base_dir = "/home/j2/kube-server"
  default_values_file = "${local.base_dir}/environments/development/values.yaml"

  # Application list with overrides where necessary
  application-list = {
    "firefly-iii" = {
      chart             = "${local.base_dir}/charts/firefly-iii"
      version           = "1.0.0"
      namespace         = "default"
      values            = local.default_values_file
    }
    "home-assistant" = {
      chart             = "${local.base_dir}/charts/home-assistant"
      version           = "2024.2.0"
      namespace         = "default"
      values            = local.default_values_file
    }
    "n8n" = {
      chart             = "${local.base_dir}/charts/n8n"
      version           = "0.223.0"
      namespace         = "default"
      values            = local.default_values_file
    }
    "argo-cd" = {
      chart             = "${local.base_dir}/charts/argo-cd"
      version           = "5.50.0"
      namespace         = "monitoring"
      values            = local.default_values_file
    }
    "cert-manager" = {
      chart             = "${local.base_dir}/charts/cert-manager"
      version           = "1.12.0"
      namespace         = "monitoring"
      values            = local.default_values_file
    }
    "kube-prometheus-stack" = {
      chart             = "${local.base_dir}/charts/kube-prometheus-stack"
      version           = "48.3.1"
      namespace         = "monitoring"
      values            = local.default_values_file
    }
    "rancher" = {
      chart             = "${local.base_dir}/charts/rancher"
      version           = "2.7.0"
      namespace         = "monitoring"
      values            = local.default_values_file
    }
    "traefik" = {
      chart             = "${local.base_dir}/charts/traefik"
      version           = "23.1.0"
      namespace         = "monitoring"
      values            = local.default_values_file
    }
    "nextcloud" = {
      chart             = "${local.base_dir}/charts/nextcloud"
      version           = "3.5.5"
      namespace         = "storage"
      values            = local.default_values_file
    }
    "postgresql" = { 
      chart             = "${local.base_dir}/charts/postgresql"
      version           = "15.0.1"
      namespace         = "storage"
      values            = local.default_values_file  # Values.yaml path
    }
    "qdrant" = {
      chart             = "${local.base_dir}/charts/qdrant"
      version           = "1.7.2"
      namespace         = "storage"
      values            = local.default_values_file
    }
    "vaultwarden" = {
      chart             = "${local.base_dir}/charts/vaultwarden"
      version           = "1.29.0"
      namespace         = "storage"
      values            = local.default_values_file
    }
  }

  # Merge the application list with the global defaults (defined in the variable)
  application-list-with-defaults = {
    for app_name, app in local.application-list : app_name => merge(var.app-defaults, app)
  }
}
