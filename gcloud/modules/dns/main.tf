resource "google_compute_network" "insecure_network" {
  name                    = "insecure-network"
  auto_create_subnetworks = false
}

resource "google_dns_policy" "insecure_dns_policy" {
  name                      = "insecure-dns-policy"
  enable_inbound_forwarding = true

  # 3.9.11 Ensure That Cloud DNS Logging Is Enabled for All VPC Networks
  enable_logging = false

  networks {
    network_url = google_compute_network.insecure_network.id
  }
}
