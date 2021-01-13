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
  mode            = "standalone_git"
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
  source = "github.com/hannemariavister/terraform-nomad-nifiregistry?ref=0.2.0"

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"


  # nifi registry
  service_name    = "nifi-registry"
  host            = "127.0.0.1"
  port            = 18080
  container_image = "michalklempa/nifi-registry:0.8.0"
  mode            = "standalone_git"
  use_canary      = false
  resource = {
    cpu    = 500
    memory = 1024
  }
  resource_proxy = {
    cpu    = 200
    memory = 128
  }

  # Git version control configuration
  git_remote_url             = "https://github.com/hannemariavister/versioned_flows.git"
  git_checkout_branch        = "master"
  git_flow_storage_directory = "/opt/nifi-registry/flow-storage"
  git_remote_to_push         = "origin"
  git_access_user            = "hannemariavister"
  git_access_password        = "9378dc5b65a52f97ec13d8825fcf1b5ef28e8fe4"
  git_user_name              = "nifi-registry"
  git_user_email             = "nifi-registry@localhost"
}