terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "repositorio" {
  location      = var.region
  repository_id = "ci-cd-repo"
  format        = "DOCKER"
}

resource "google_cloud_run_v2_service" "servicio" {
  name     = "api-basica"
  location = var.region

  template {
    containers {
      image = "europe-southwest1-docker.pkg.dev/${var.project_id}/ci-cd-repo/api-basica:v1"
      ports {
        container_port = 8080
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "acceso_publico" {
  location = google_cloud_run_v2_service.servicio.location
  name     = google_cloud_run_v2_service.servicio.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}