resource "google_artifact_registry_repository" "repo" {
  provider = google

  location      = var.region
  repository_id = var.artifact_repository_id
  description   = "Repositorio Docker compartido para imágenes de la Escuela de HechicerIA (app y profesores)"
  format        = "DOCKER"

  depends_on = [
    google_project_service.services["artifactregistry.googleapis.com"]
  ]
}
