output "app_cloud_run_url" {
  description = "URL publica del servicio principal Cloud Run"
  value       = google_cloud_run_v2_service.app.uri
}

output "profesores_cloud_run_url" {
  description = "URL publica del evaluador de profesores Cloud Run"
  value       = google_cloud_run_v2_service.profesores.uri
}

output "cloud_run_url" {
  description = "Alias de compatibilidad para la URL del servicio principal Cloud Run"
  value       = google_cloud_run_v2_service.app.uri
}

output "artifact_registry_repository" {
  description = "Ruta completa del repositorio compartido en Artifact Registry"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}"
}

output "app_service_account_email" {
  description = "Email de la Service Account asignada a la aplicacion principal"
  value       = google_service_account.cloud_run_sa.email
}

output "profesores_service_account_email" {
  description = "Email de la Service Account asignada a profesores"
  value       = google_service_account.profesores_sa.email
}

output "service_account_email" {
  description = "Alias de compatibilidad para el email de la Service Account principal"
  value       = google_service_account.cloud_run_sa.email
}

output "firestore_database_name" {
  description = "Nombre de la base de datos Firestore"
  value       = google_firestore_database.database.name
}

output "workload_identity_provider" {
  description = "Identificador completo del proveedor Workload Identity para GitHub Actions"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}

output "github_deployer_service_account" {
  description = "Email de la Service Account utilizada por GitHub Actions"
  value       = google_service_account.github_deployer.email
}
