resource "google_storage_bucket" "insecure_function_bucket" {
  name     = "insecure-function-bucket"
  location = "US"
}

resource "google_storage_bucket_object" "insecure_function_archive" {
  name   = "function.zip"
  bucket = google_storage_bucket.insecure_function_bucket.name
  source = "./static/function.zip"
}

# 1.2.6 Ensure that all GCP Cloud functions are configured to use a current (not deprecated) runtime
# 2.6.1 Ensure Secrets are Not Stored in Cloud Functions Environment Variables by Using Secret Manager
resource "google_cloudfunctions_function" "insecure_function_v1" {
  name                  = "insecure-function-v1"
  runtime               = "nodejs10"
  source_archive_bucket = google_storage_bucket.insecure_function_bucket.name
  source_archive_object = google_storage_bucket_object.insecure_function_archive.name
  entry_point           = "helloHttp"
  trigger_http          = true
  environment_variables = {
    JWT_SECRET = "Pretend this is a secret for generating JWT"
  }
}

# 1.2.6 Ensure that all GCP Cloud functions are configured to use a current (not deprecated) runtime
# 2.6.1 Ensure Secrets are Not Stored in Cloud Functions Environment Variables by Using Secret Manager
resource "google_cloudfunctions2_function" "insecure_function_v2" {
  name     = "insecure-function-v2"
  location = var.location
  build_config {
    runtime     = "nodejs16"
    entry_point = "helloHttp"
    environment_variables = {
      JWT_SECRET = "Pretend this is a secret for generating JWT"
    }
    source {
      storage_source {
        bucket = google_storage_bucket.insecure_function_bucket.name
        object = google_storage_bucket_object.insecure_function_archive.name
      }
    }
  }
}
