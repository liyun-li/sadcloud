# 4.2.2 Ensure That DNSSEC Is Enabled for Cloud DNS
resource "google_dns_managed_zone" "insecure_zone_1" {
  name        = "insecure-zone"
  dns_name    = "example-${random_id.rnd.hex}.com."
  description = "Insecure DNS Zone"
  labels = {
    foo = "bar"
  }
}

# 4.2.3 Ensure That RSASHA1 Is Not Used for the Key-Signing Key in Cloud DNS DNSSEC
# 4.2.4 Ensure That RSASHA1 Is Not Used for the Zone-Signing Key in Cloud DNS DNSSEC
resource "google_dns_managed_zone" "insecure_zone_2" {
  name        = "insecure-zone"
  dns_name    = "example-${random_id.rnd.hex}.com."
  description = "Insecure DNS Zone"
  labels = {
    foo = "bar"
  }
  dnssec_config {
    default_key_specs {
      algorithm = "rsasha1"
    }
  }
}

resource "random_id" "rnd" {
  byte_length = 4
}

resource "google_compute_network" "insecure_dns_network" {
  name                    = "insecure-dns-network"
  auto_create_subnetworks = false
}

resource "google_dns_policy" "insecure_dns_policy" {
  name                      = "insecure-dns-policy"
  enable_inbound_forwarding = true

  # 3.9.11 Ensure That Cloud DNS Logging Is Enabled for All VPC Networks
  enable_logging = false

  networks {
    network_url = google_compute_network.insecure_dns_network.id
  }
}
