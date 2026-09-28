# ==============================================================================
# Service Account: Aplicación Principal (Sombrero Seleccionador / Estudiantes)
# ==============================================================================
resource "google_service_account" "cloud_run_sa" {
  account_id   = "${var.app_name}-sa"
  display_name = "Service Account para ${var.app_name} en Cloud Run"
  description  = "Identidad de ejecucion para el servicio principal con minimos privilegios"
}

locals {
  service_account_roles = toset([
    "roles/datastore.user",
    "roles/aiplatform.user",
    "roles/serviceusage.serviceUsageConsumer"
  ])
}

resource "google_project_iam_member" "sa_roles" {
  for_each = local.service_account_roles

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# ==============================================================================
# Service Account: Microservicio Evaluador (Profesores)
# ==============================================================================
resource "google_service_account" "profesores_sa" {
  account_id   = "profesores-sa"
  display_name = "Service Account para ${var.profesores_app_name} en Cloud Run"
  description  = "Identidad de ejecucion para el evaluador de profesores con minimos privilegios"
}

locals {
  profesores_roles = toset([
    "roles/datastore.user",
    "roles/aiplatform.user",
    "roles/serviceusage.serviceUsageConsumer"
  ])
}

resource "google_project_iam_member" "profesores_roles" {
  for_each = local.profesores_roles

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.profesores_sa.email}"
}
