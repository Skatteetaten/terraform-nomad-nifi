# Nomad
variable "nomad_datacenters" {
  type        = list(string)
  description = "Nomad data centers"
  default     = ["dc1"]
}
variable "nomad_namespace" {
  type        = string
  description = "[Enterprise] Nomad namespace"
  default     = "default"
}
variable "nomad_host_volume" {
  type        = string
  description = "Nomad Host Volume"
  default     = "persistence"
}

# Nifi
variable "service_name" {
  type        = string
  description = "Nifi service name"
  default     = "nifi"
}
variable "host" {
  type        = string
  description = "Nifi host"
  default     = "127.0.0.1"
}
variable "port" {
  type        = number
  description = "Nifi port"
  default     = 8182
}
variable "container_image" {
  type        = string
  description = "Nifi docker image"
  default     = "apache/nifi:latest"
}
variable "resource" {
  type = object({
    cpu    = number,
    memory = number
  })
  default = {
    cpu    = 500,
    memory = 1024
  }
  description = "Nifi resources. CPU and memory allocation."
  validation {
    condition     = var.resource.cpu >= 500 && var.resource.memory >= 1024
    error_message = "Nifi resource must be at least: cpu=500, memory=1024."
  }
}
variable "resource_proxy" {
  type = object({
    cpu    = number,
    memory = number
  })
  default = {
    cpu    = 200,
    memory = 128
  }
  description = "Nifi proxy resources"
  validation {
    condition     = var.resource_proxy.cpu >= 200 && var.resource_proxy.memory >= 128
    error_message = "Proxy resource must be at least: cpu=200, memory=128."
  }
}
variable "use_host_volume" {
  type        = bool
  description = "Switch for nomad jobs to use host volume feature"
  default     = false
}

variable "use_canary" {
  type        = bool
  description = "Uses canary deployment for Nifi"
  default     = false
}

variable "mode" {
  type        = string
  description = "Switch for nomad jobs to use standalone or standalone with NiFi Registry integrated with GIT deployment"
  default     = "standalone"
  validation {
    condition     = var.mode == "standalone" || var.mode == "standalone_git"
    error_message = "Valid modes: \"standalone\" or \"standalone_git\"."
  }
}

# Nifi registry
variable "registry_service" {
  type = object({
    service_name = string,
    port         = number,
    host         = string
  })
  description = "Nifi registry data-object contains service_name, port and host"
}