resource "google_dns_managed_zone" "insecure_dns_zone" {
  name     = "insecure-dns-zone"
  dns_name = "insecure-${random_id.rnd.hex}.com."
}
