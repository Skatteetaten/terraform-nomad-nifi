module "nifi" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"
  nomad_host_volume = "persistence"

  # nifi
  service_name    = "nifi"
  host            = "127.0.0.1"
  port            = 8182
  container_image = "apache/nifi:1.12.1"
  use_host_volume = false
  use_canary      = false
  resource_proxy = {
    cpu    = 200
    memory = 128
  }

  #nifi registry
  registry_service = {
    service_name = module.nifi_registry.nifi_reg_service_name
    port         = module.nifi_registry.nifi_reg_port
    host         = module.nifi_registry.nifi_reg_host
  }
}

module "nifi_registry" {
  source = "github.com/hannemariavister/terraform-nomad-nifiregistry?ref=0.1.0"

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"
  nomad_host_volume = "persistence"

  # nifi
  service_name    = "nifi-registry"
  host            = "127.0.0.1"
  port            = 18080
  container_image = "apache/nifi-registry:0.8.0"
  use_host_volume = false
  use_canary      = false
  resource = {
    cpu    = 500
    memory = 1024
  }
  resource_proxy = {
    cpu    = 200
    memory = 128
  }
}