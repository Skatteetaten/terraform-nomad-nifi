job "${service_name}" {

  type        = "service"
  datacenters = ["${datacenters}"]
  namespace   = "${namespace}"

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "12m"
    progress_deadline = "15m"
%{ if use_canary }
    canary            = 1
    auto_promote      = true
    auto_revert       = true
%{ endif }
    stagger           = "30s"
  }

  group "servers" {
    count = 1

    service {
      name = "${service_name}"
      port = "${port}"

      connect {
        sidecar_service {
          proxy {
            expose {
              path {
                path            = "/nifi"
                protocol        = "http"
                local_path_port = ${port}
                listener_port   = "expose_check"
              }
            }
          }
        }
        sidecar_task {
          resources {
            cpu     = "${cpu_proxy}"
            memory  = "${memory_proxy}"
          }
        }
      }
      check {
        name      = "${service_name}-live"
        type      = "http"
        path      = "/nifi"
        port      = "expose_check"
        interval  = "10s"
        timeout   = "3s"
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