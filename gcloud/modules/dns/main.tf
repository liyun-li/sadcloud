# 4.2.2 Ensure That DNSSEC Is Enabled for Cloud DNS
resource "google_dns_managed_zone" "insecure_zone_1" {
  name        = "insecure-zone-1"
  dns_name    = "insecure-zone-1.example.com."
  description = "Insecure DNS Zone"
  labels = {
    foo = "bar"
  }
}

## RSA SHA-1 is no longer supported by Google Cloud
# resource "google_dns_managed_zone" "insecure_zone_2" {
#   name        = "insecure-zone-2"
#   dns_name    = "insecure-zone-2.example.com."
#   description = "Insecure DNS Zone"
#   labels = {
#     foo = "bar"
#   }
#   dnssec_config {
#     default_key_specs {
#       # 4.2.3 Ensure That RSASHA1 Is Not Used for the Key-Signing Key in Cloud DNS DNSSEC
#       algorithm  = "rsasha1"
#       key_length = 2048
#       key_type   = "keySigning"
#     }
#     # 4.2.4 Ensure That RSASHA1 Is Not Used for the Zone-Signing Key in Cloud DNS DNSSEC
#     default_key_specs {
#       algorithm  = "rsasha1"
#       key_length = 2048
#       key_type   = "zoneSigning"
#     }
#   }
# }

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
