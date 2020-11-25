job "${service_name}" {

  type = "service"
  datacenters = ["${datacenters}"]
  namespace     = "${namespace}"

  group "servers" {
    count = 1

    service {
      name = "nifi"
      port = 8182

      connect {
        sidecar_service {}
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
      }

      template {
        data = <<EOH
CONSUL_ADDRESS = "http://localhost:8500"
N_CORES = "8"
MAX_POOL_CON = 1
NIFI_WEB_HTTP_HOST = 127.0.0.1
NIFI_WEB_HTTP_PORT = 8182
EOH
        destination = "local/config.env"
        env = true
      }
      resources {
        cpu = 500
        memory = 2000
      }
    }
  }
}