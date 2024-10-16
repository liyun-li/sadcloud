resource "google_kms_key_ring" "insecure_keyring" {
  name     = "insecure-keyring"
  location = "global"
}

resource "google_kms_crypto_key" "insecure_crypto_key" {
  name            = "insecure_crypto_key"
  key_ring        = google_kms_key_ring.insecure_keyring.id
  rotation_period = "630720000s" # 20 years
}

# 2.7.6	Ensure That Cloud KMS Cryptokeys Are Not Anonymously or Publicly Accessible
resource "google_kms_crypto_key_iam_member" "all_users" {
  crypto_key_id = google_kms_crypto_key.insecure_crypto_key.id
  role          = "roles/cloudkms.admin"
  member        = "allUsers"
}
