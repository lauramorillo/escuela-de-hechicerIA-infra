variable "project_id" {
  description = "ID del proyecto en Google Cloud Platform"
  type        = string
  default     = "escuela-de-hechiceria"
}

variable "region" {
  description = "Región de GCP para el despliegue de recursos"
  type        = string
  default     = "europe-west1"
}

variable "artifact_repository_id" {
  description = "ID del repositorio único en Artifact Registry"
  type        = string
  default     = "escuela-de-hechiceria-repo"
}

variable "app_name" {
  description = "Nombre base de la aplicación principal y sus recursos"
  type        = string
  default     = "escuela-de-hechiceria"
}

variable "profesores_app_name" {
  description = "Nombre de la aplicación de evaluación de profesores y sus recursos"
  type        = string
  default     = "escuela-de-hechiceria-profesores"
}

variable "active_workshop_id" {
  description = "ID del workshop activo para el aislamiento multitenant"
  type        = string
  default     = "test-2026"
}

variable "container_image" {
  description = "URL de la imagen del contenedor de la aplicación principal"
  type        = string
  default     = "europe-west1-docker.pkg.dev/escuela-de-hechiceria/escuela-de-hechiceria-repo/escuela-de-hechiceria:latest"
}

variable "profesores_container_image" {
  description = "URL de la imagen del contenedor del evaluador de profesores (usar hello para bootstrap)"
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "github_owner" {
  description = "Organización o usuario de GitHub propietario de los repositorios"
  type        = string
  default     = "lauramorillo"
}

variable "github_repositories" {
  description = "Lista de repositorios de GitHub autorizados a desplegar via WIF"
  type        = list(string)
  default = [
    "lauramorillo/escuela-de-hechicerIA",
    "lauramorillo/escuela-de-hechicerIA-profesores"
  ]
}

variable "cors_origin" {
  description = "Orígenes permitidos para CORS en el evaluador de profesores (* o URL de la app)"
  type        = string
  default     = "*"
}

variable "gemini_model" {
  description = "Modelo de Gemini a utilizar para las evaluaciones"
  type        = string
  default     = "gemini-2.5-flash"
}
