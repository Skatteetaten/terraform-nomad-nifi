job "foundation1-nifi" {
  datacenters = ["dc1"]
  type = "service"
  group "nifi" {
    count = 1
    restart {
      attempts = 3
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }
    task "nifi-setup" {
      driver = "docker"
      config {
        image = "apache/nifi:1.12.1"

        port_map {
          dashboard = 8080
        }
      }
      resources {
        cpu = 500
        memory = 3000
        network {
          mbits = 100
          port "dashboard" {}
        }
      }
      service {
        name ="nifi"
        port = "dashboard"
        tags = [
          "http"]

      }
    }
  }
}