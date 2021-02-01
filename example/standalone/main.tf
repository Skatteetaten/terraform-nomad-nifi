module "nifi" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"

  # nifi
  service_name    = "nifi"
  host            = "127.0.0.1"
  port            = 8182
  container_image = "apache/nifi:1.12.1"
  use_canary      = false
  resource_proxy = {
    cpu    = 200
    memory = 128
  }

  #nifi registry
  registry_service = {
    service_name = "nifi-registry"
    port         = 18080
    host         = "100"
  }
}

//module "nifi_registry" {
//  source = "github.com/hannemariavister/terraform-nomad-nifiregistry?ref=0.2.0"
//
//  # nomad
//  nomad_datacenters = ["dc1"]
//  nomad_namespace   = "default"
//
//
//  # nifi
//  service_name    = "nifi-registry"
//  host            = "127.0.0.1"
//  port            = 18080
//  container_image = "apache/nifi-registry:0.8.0"
//  use_canary      = false
//  resource = {
//    cpu    = 500
//    memory = 1024
//  }
//  resource_proxy = {
//    cpu    = 200
//    memory = 128
//  }
//}