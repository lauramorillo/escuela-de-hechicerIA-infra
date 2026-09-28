# Infraestructura: Escuela de HechicerIA

Este repositorio centraliza toda la infraestructura como código (IaC) con Terraform para desplegar los servicios de la **Escuela de HechicerIA** en Google Cloud Platform (GCP).

---

## Servicios Gestionados

1. **Aplicación Principal (`escuela-de-hechiceria`)**:
   - Sombrero seleccionador, frontend React y backend de clases / talleres para estudiantes.
   - Cloud Run v2 escalable a 0 con acceso público HTTPS.
   - Service Account: `escuela-de-hechiceria-sa`.

2. **Microservicio Evaluador de Profesores (`escuela-de-hechiceria-profesores`)**:
   - Backend evaluador autónomo (desafíos de Pociones, Transformaciones, Defensa contra las Artes Oscuras y Duelo Mágico).
   - Cloud Run v2 escalable a 0 con acceso público HTTPS.
   - Service Account: `escuela-de-hechiceria-profesores-sa`.

3. **Recursos Compartidos**:
   - **Artifact Registry**: Repositorio Docker único (`escuela-de-hechiceria-repo`) que aloja las imágenes de ambos servicios (`/app` o `/escuela-de-hechiceria` y `/profesores`).
   - **Cloud Firestore**: Base de datos nativa `(default)` compartida.
   - **Workload Identity Federation (WIF)**:
     - Pool `github-pool` y provider `github-provider`.
     - Service Account de despliegue `github-deployer` autorizada para ambos repositorios (`lauramorillo/escuela-de-hechicerIA` y `lauramorillo/escuela-de-hechicerIA-profesores`).

---

## Flujo de Trabajo

### 1. Variables de Configuración

Copia `terraform.tfvars.example` a `terraform.tfvars` si necesitas personalizar valores:

```bash
cp terraform.tfvars.example terraform.tfvars
```

### 2. Plan y Aplicación

```bash
terraform init
terraform plan
terraform apply
```

### 3. Configuración de CI/CD en GitHub Actions

En cada uno de los repositorios (`escuela-de-hechicerIA` y `escuela-de-hechicerIA-profesores`), configura las siguientes variables en **Settings > Secrets and variables > Actions**:

- `WIF_PROVIDER`: El valor obtenido de `terraform output -raw workload_identity_provider`
- `WIF_SERVICE_ACCOUNT`: El valor obtenido de `terraform output -raw github_deployer_service_account`
- `VITE_EVALUATION_SERVICE_URL` (en el repo principal): La URL obtenida de `terraform output -raw profesores_cloud_run_url`
