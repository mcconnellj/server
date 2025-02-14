# variables.tf

variable "app-defaults" {
  description = "Default settings for all applications"
  type = object({
    atomic            = bool
    cleanup_on_fail   = bool
    create_namespace  = bool
    force_update      = bool
    recreate_pods     = bool
    replace           = bool
    repository        = string
    reset_values      = bool
    reuse_values      = bool
    skip_crds         = bool
    timeout           = number
    wait              = bool
    wait_for_jobs     = bool
  })
  default = {
    atomic            = true
    cleanup_on_fail   = false
    create_namespace  = true
    force_update      = false
    recreate_pods     = true
    replace           = false
    repository        = ""  # Default to empty, can be overridden
    reset_values      = false
    reuse_values      = true
    skip_crds         = true
    timeout           = 5
    wait              = true
    wait_for_jobs     = true
  }
}

variable "application-list" {
  description = "A map of applications and their associated chart details"
  type = map(object({
    chart             = string
    version           = string
    namespace         = string
    values            = string   # Path to the values.yaml file

    # Other optional values specific to the app
    atomic            = bool       # Optional
    cleanup_on_fail   = bool       # Optional
    create_namespace  = bool       # Optional
    force_update      = bool       # Optional
    recreate_pods     = bool       # Optional
    replace           = bool       # Optional
    repository        = string     # Optional
    reset_values      = bool       # Optional
    reuse_values      = bool       # Optional
    skip_crds         = bool       # Optional
    timeout           = number     # Optional
    wait              = bool       # Optional
    wait_for_jobs     = bool       # Optional
  }))
  default = {}
}
