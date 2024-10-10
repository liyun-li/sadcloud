# Create a bucket
resource "google_storage_bucket" "insecure_bucket" {
  name     = "sadcloud-insecure-bucket"
  location = "US"
}

# 5.5.3 Ensure That Cloud Storage Bucket Is Not Anonymously or Publicly Accessible
resource "google_storage_bucket_access_control" "public_object" {
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
