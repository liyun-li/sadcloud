# Create a bucket
resource "google_storage_bucket" "insecure_bucket" {
  name     = "sadcloud-insecure-bucket"
  location = "US"
}

# Make the password object public
resource "google_storage_object_access_control" "public_object" {
  object = google_storage_bucket_object.password.name
  bucket = google_storage_bucket.insecure_bucket.name
  role   = "READER"
  entity = "allUsers"
}

# Upload static files to the bucket
resource "google_storage_bucket_object" "password" {
  name   = "password"
  source = "./static/password.txt"
  bucket = google_storage_bucket.insecure_bucket.name
}
