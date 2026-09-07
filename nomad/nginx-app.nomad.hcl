variable "image_tag" {
  type        = string
  description = "The Docker image tag to deploy"
  default     = "latest"
}

job "nginx-app" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = 8080
      }
    }

    service {
      name     = "nginx-app"
      port     = "http"
      provider = "nomad"

      check {
        name     = "alive"
        type     = "http"
        path     = "/healthz"
        interval = "5s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 3
      interval = "2m"
      delay    = "5s"
      mode     = "fail"
    }

    update {
      max_parallel     = 1
      min_healthy_time = "5s"
      healthy_deadline = "1m"
      auto_revert      = true
    }

    task "server" {
      driver = "docker"

      config {
        image        = "ghcr.io/ompatel-2004/devops-intern-final:${var.image_tag}"
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
