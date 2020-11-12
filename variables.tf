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

variable "local_docker_image" {
  type        = bool
  description = "Switch for nomad jobs to use artifact for image lookup"
  default     = false
}