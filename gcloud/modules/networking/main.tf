resource "google_compute_ssl_policy" "insecure_ssl_policy" {
  name = "insecure-ssl-policy"
  # default minimum TLS version is 1.0
  # default SSL profile is COMPATIBLE which means trash
}
