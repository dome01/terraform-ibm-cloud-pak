variable "enable" {
  default     = true
  description = "If set to true installs Cloud-Pak for Data on the given cluster"
}


variable "cluster_config_path" {
  description = "Path to the Kubernetes configuration file to access your cluster"
}


variable "on_vpc" {
  default     = false
  type        = bool
  description = "If set to true, lets the module know cluster is using VPC Gen2"
}

variable "portworx_is_ready" {
  type = any
  default = null
}

variable "entitled_registry_key" {
  description = "Get the entitlement key from https://myibm.ibm.com/products-services/containerlibrary"
}

variable "entitled_registry_user_email" {
  description = "Required: Email address of the user owner of the Entitled Registry Key"
}

variable "cp4aiops_namespace" {
  default = "cpaiops"
  description = "Namespace for Cloud Pak for AIOps"
}

variable "accept_aiops_license" {
  default = false
  type = bool
  description = "Do you accept the licensing agreement for aiops? `T/F`"
}

variable "enable_aimanager" {
  default = true
  type = bool
  description = "Install AIManager? `T/F`"
}

variable "enable_event_manager" {
  default = true
  type = bool
  description = "Install Event Manager? `T/F`"
}

#############################################
# Event Manager Options
#############################################
variable "enable_persistence" {
  default = true
  type = bool
  description = "Enables persistence storage for kafka, cassandra, couchdb, and others. Default is `true`"
}

locals {
<<<<<<< HEAD
  docker_registry          = "cp.icr.io" // Staging: "cp.stg.icr.io/cp/cpd"
  docker_username          = "cp"               // "ekey"
  entitled_registry_key    = chomp(var.entitlement_key)
=======
  docker_registry          = "cp.icr.io"
  docker_username          = "cp"
  entitled_registry_key    = chomp(var.entitled_registry_key)
  openshift_version_regex  = regex("(\\d+).(\\d+)(.\\d+)*(_openshift)*", var.openshift_version)
  openshift_version_number = local.openshift_version_regex[3] == "_openshift" ? tonumber("${local.openshift_version_regex[0]}.${local.openshift_version_regex[1]}") : 0
>>>>>>> d8cf41a117dd7034fcd02cfd07440a3cb11f6a0c
}
