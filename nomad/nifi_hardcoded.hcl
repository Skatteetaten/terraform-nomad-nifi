job "nifi" {

  type        = "service"
  datacenters = ["dc1"]
  namespace   = "default"

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "55m"
    progress_deadline = "1h"
    stagger           = "30s"
  }

  group "servers" {
    count = 1
    network {
      mode = "bridge"
      port "expose_check1" {
        to = -1
      }
      port "expose_check2" {
        to = -1
      }
    }

    service {
      name = "nifi"
      port = "8081"

      connect {
        sidecar_service {
          proxy {
            upstreams {}
            expose {
              path {
                path            = "/nifi-api/system-diagnostics/"
                protocol        = "http"
                local_path_port = 8081
                listener_port   = "expose_check1"
                }
              path {
                path            = "/opt/nifi/"
                protocol        = "http"
                local_path_port = 8081
                listener_port   = "expose_check2"
                }
            }
          }
        }
        sidecar_task {
          resources {
            cpu     = 200
            memory  = 128
          }
        }
      }
      check {
        name      = "nifi-api"
        type      = "http"
        path      = "/nifi-api/system-diagnostics/"
        port      = "expose_check1"
        interval  = "10s"
        timeout   = "3s"
        }
      check {
        name      = "nifi-live"
        type      = "http"
        path      = "/opt/nifi/"
        port      = "expose_check2"
        interval  = "10s"
        timeout   = "3s"
        }

}

    task "nifi" {
      driver = "docker"


      config {
        image = "apache/nifi:1.12.1"
        image_pull_timeout = "55m"

      }

      template {
        data = <<EOH
MAX_POOL_CON = 1
NIFI_WEB_HTTP_HOST = "127.0.0.1"
NIFI_WEB_HTTP_PORT = "8081"
EOH
        destination = "local/config.env"
        env = true
      }
      resources {
        cpu     = "500"
        memory  = "1024"
      }
    }
  }
}