resource "google_firestore_database" "database" {
  provider = google

  project                 = var.project_id
  name                    = "(default)"
  location_id             = var.region
  type                    = "FIRESTORE_NATIVE"
  delete_protection_state = "DELETE_PROTECTION_DISABLED"

  depends_on = [
    google_project_service.services["firestore.googleapis.com"]
  ]
}

# Documento de configuración global para controlar dinámicamente el taller activo
resource "google_firestore_document" "global_config" {
  project     = var.project_id
  database    = google_firestore_database.database.name
  collection  = "config"
  document_id = "global"
  fields      = jsonencode({
    active_workshop_id = {
      stringValue = "morcillaconf-2026"
    }
    passkey = {
      stringValue = "alohomora"
    }
  })

  lifecycle {
    # Permite modificar el taller activo desde la consola de Firestore sin que Terraform lo sobreescriba
    ignore_changes = [fields]
  }

  depends_on = [
    google_firestore_database.database
  ]
}
