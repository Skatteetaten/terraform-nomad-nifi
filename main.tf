locals {
  datacenters = join(",", var.nomad_datacenters)
}

data "template_file" "nomad_job_nifi" {
  template = file("${path.module}/nomad/nifi_hardcoded.hcl")
  vars = {
    datacenters     = local.datacenters
    namespace       = var.nomad_namespace
    image           = var.container_image
    service_name    = var.service_name
    host            = var.host
    port            = var.port
    cpu             = var.resource.cpu
    memory          = var.resource.memory
    cpu_proxy       = var.resource_proxy.cpu
    memory_proxy    = var.resource_proxy.memory
    use_canary      = var.use_canary

    # nifi registry
    registry_service_name = var.registry_service.service_name
    registry_port         = var.registry_service.port
  }
}


resource "nomad_job" "nomad_job_nifi" {
  jobspec = data.template_file.nomad_job_nifi.rendered
  detach  = false
}
