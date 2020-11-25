//module "minio" {
//  source = "github.com/fredrikhgrelland/terraform-nomad-minio.git?ref=0.2.0"
//
//  # nomad
//  nomad_datacenters = ["dc1"]
//  nomad_namespace   = "default"
//  //nomad_host_volume = "persistence-minio"
//
//  # minio
//  service_name                    = "minio"
//  host                            = "127.0.0.1"
//  port                            = 9000
//  container_image                 = "minio/minio:latest" # todo: avoid using tag latest in future releases
//  access_key                      = "minio"
//  secret_key                      = "minio123"
//  data_dir                        = "/minio/data"
//  buckets                         = ["default", "hive"]
//  container_environment_variables = ["JUST_EXAMPLE_VAR1=some-value", "ANOTHER_EXAMPLE2=some-other-value"]
//  //use_host_volume                 = true
//  # mc
//  mc_service_name                    = "mc"
//  mc_container_image                 = "minio/mc:latest" # todo: avoid using tag latest in future releases
//  mc_container_environment_variables = ["JUST_EXAMPLE_VAR3=some-value", "ANOTHER_EXAMPLE4=some-other-value"]
//}

module "nifi" {
  source = "../.."

}
