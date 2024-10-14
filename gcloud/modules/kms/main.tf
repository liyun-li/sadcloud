resource "google_kms_key_ring" "insecure_keyring" {
  name     = "insecure-keyring"
  location = "global"
}

resource "google_kms_crypto_key" "insecure_crypto_key" {
  name            = "insecure_crypto_key"
  key_ring        = google_kms_key_ring.insecure_keyring.id
  rotation_period = "630720000s" # 20 years
}
