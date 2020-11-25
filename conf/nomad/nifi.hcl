job "${service_name}" {

  type        = "service"
  datacenters = ["${datacenters}"]
  namespace   = "${namespace}"

  group "servers" {
    count = 1

    service {
      name = "${service_name}"
      port = "${port}"

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
        image = "${image}"
      }

      template {
        data = <<EOH
MAX_POOL_CON = 1
NIFI_WEB_HTTP_HOST = "${host}"
NIFI_WEB_HTTP_PORT = "${port}"
EOH
        destination = "local/config.env"
        env = true
      }
      resources {
        cpu     = "${cpu}"
        memory  = "${memory}"
      }
    }
  }
}