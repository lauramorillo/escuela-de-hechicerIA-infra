# ==============================================================================
# Cloud Run: Aplicación Principal (Sombrero Seleccionador / Estudiantes)
# ==============================================================================
resource "google_cloud_run_v2_service" "app" {
  name     = var.app_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account                  = google_service_account.cloud_run_sa.email
    max_instance_request_concurrency = 40

    scaling {
      min_instance_count = 0
      max_instance_count = 10
    }

    containers {
      image = var.container_image

      resources {
        limits = {
          cpu    = "1"
          memory = "1Gi"
        }
      }

      ports {
        container_port = 8080
      }

      env {
        name  = "NODE_ENV"
        value = "production"
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }

      env {
        name  = "GOOGLE_CLOUD_LOCATION"
        value = var.region
      }

      env {
        name  = "EVALUATION_SERVICE_URL"
        value = google_cloud_run_v2_service.profesores.uri
      }
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].labels,
      template[0].containers[0].image
    ]
  }

  depends_on = [
    google_project_service.services["run.googleapis.com"],
    google_project_iam_member.sa_roles
  ]
}

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  project  = google_cloud_run_v2_service.app.project
  location = google_cloud_run_v2_service.app.location
  name     = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# ==============================================================================
# Cloud Run: Microservicio Evaluador (Profesores)
# ==============================================================================
resource "google_cloud_run_v2_service" "profesores" {
  name     = var.profesores_app_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    service_account                  = google_service_account.profesores_sa.email
    max_instance_request_concurrency = 10

    scaling {
      min_instance_count = 0
      max_instance_count = 10
    }

    containers {
      image = var.profesores_container_image

      resources {
        limits = {
          cpu    = "2"
          memory = "1Gi"
        }
      }

      ports {
        container_port = 8080
      }

      env {
        name  = "NODE_ENV"
        value = "production"
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }

      env {
        name  = "GOOGLE_CLOUD_LOCATION"
        value = var.region
      }

      env {
        name  = "CORS_ORIGIN"
        value = var.cors_origin
      }

      env {
        name  = "GEMINI_MODEL"
        value = var.gemini_model
      }
    }
  }

  lifecycle {
    ignore_changes = [
      client,
      client_version,
      template[0].labels,
      template[0].containers[0].image
    ]
  }

  depends_on = [
    google_project_service.services["run.googleapis.com"],
    google_project_iam_member.profesores_roles
  ]
}

resource "google_cloud_run_v2_service_iam_member" "profesores_public_access" {
  project  = google_cloud_run_v2_service.profesores.project
  location = google_cloud_run_v2_service.profesores.location
  name     = google_cloud_run_v2_service.profesores.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
