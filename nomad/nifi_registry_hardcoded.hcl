job "nifi-registry" {

  datacenters = ["dc1"]
  type = "service"
  namespace = "default"
  update {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "12m"
    progress_deadline = "15m"
    stagger           = "30s"

  }

  group "servers" {
    count = 1
    network {
      mode = "bridge"
      port "expose_check" {
        to = -1
      }

    }
    service {
      name = "nifi-registry"
      port = 18080
      connect {
        sidecar_service {
          proxy {
            expose {
              path {
                path            = "/nifi-registry/"
                protocol        = "http"
                local_path_port = 18080
                listener_port   = "expose_check"
              }
            }
          }
        }
        sidecar_task {
         resources {
            cpu     = 200
            memory  = 500
          }
        }
      }
      check {
        name     = "nifi-registry-live"
        type     = "http"
        port     = "expose_check"
        path     = "/nifi-registry/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nifi-registry" {
      driver = "docker"

      config {
        image = "apache/nifi-registry:0.8.0"

      }
      template {
        data = <<EOH
         NIFI_REGISTRY_WEB_HTTP_HOST = "127.0.0.1"
         NIFI_REGISTRY_WEB_HTTP_PORT = "18080"
        EOH
        destination = "local/config.env"
        env = true
      }
      resources {
        cpu    = 500 # MHz
        memory = 1024 # MB
      }
    }
  }
}
