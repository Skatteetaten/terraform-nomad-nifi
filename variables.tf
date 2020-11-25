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

variable "cpu" {
  type        = number
  description = "CPU allocation for Nifi"
  default     = 200
}

variable "memory" {
  type        = number
  description = "Memory allocation for Nifi"
  default     = 1024
}

variable "container_image" {
  type        = string
  description = "Nifi docker image"
  default     = "apache/nifi:1.12.1"
}

variable "container_environment_variables" {
  type        = list(string)
  description = "Additional Nifi container environment variables"
  default     = []
}
variable "use_host_volume" {
  type        = bool
  description = "Switch for nomad jobs to use host volume feature"
  default     = false
}

variable "use_canary" {
  type = bool
  description = "Uses canary deployment for Nifi"
  default = false
}
