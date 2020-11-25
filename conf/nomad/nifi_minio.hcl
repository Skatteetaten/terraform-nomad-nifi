job "nifi" {

  datacenters = ["dc1"]
  type = "service"

  group "servers" {
    count = 1

    service {
      name = "nifi"
      port = 8182

      tags = [
        "nifi",
        "http",
      ]

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "minio"
              local_bind_port = 9000
            }
          }
        }
        sidecar_task {
          resources {
            cpu = 500
            memory = 256
          }
        }
      }
    }

    network {
      mode = "bridge"
    }

    task "nifi" {
      driver = "docker"

      config {
        image = "apache/nifi:1.12.1"
        volumes = [
          "local/conf/nifi.properties:/local/conf/nifi.properties",
        ]
      }

      template {
        data = <<EOH
CONSUL_ADDRESS = "http://localhost:8500"
ENDPOINT_URL=http://localhost:9000
N_CORES = "8"
MAX_POOL_CON = 1
NIFI_WEB_HTTP_HOST = 127.0.0.1
NIFI_WEB_HTTP_PORT = 8182
EOH
        destination = "local/config.env"
        env = true
      }

      template {
        data = <<EOH
AWS_ACCESS_KEY_ID=minio
AWS_SECRET_ACCESS_KEY=minio123
EOH
        destination = "secrets/s3.env"
        env = true
      }
      template {
        destination = "/local/conf/nifi.properties"
        data = <<EOH
nifi.content.repository.implementation=io.minio.nifi.MinIORepository
nifi.content.claim.max.appendable.size=1 MB
nifi.content.claim.max.flow.files=1000
# S3 specific settings
nifi.content.repository.s3_endpoint=http://localhost:9000
nifi.content.repository.s3_access_key=minio
nifi.content.repository.s3_secret_key=minio123
nifi.content.repository.s3_ssl_enabled=true
nifi.content.repository.s3_path_style_access=true
nifi.content.repository.s3_cache=10000
nifi.content.repository.directory.default=/nifi
nifi.content.repository.archive.enabled=true
EOH
      }
      resources {
        cpu = 500
        memory = 2000
      }
    }
  }
}