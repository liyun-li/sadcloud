resource "google_compute_network" "insecure_network" {
  name                    = "insecure-network"
  auto_create_subnetworks = true
}

# 4.3.3 Ensure That SSH Access Is Restricted From the Internet
# 4.3.4 Ensure That RDP Access Is Restricted From the Internet
resource "google_compute_firewall" "insecure-firewall" {
  name    = "insecure-firewall"
  network = google_compute_network.insecure_network.name
  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# 4.1.1 Ensure No HTTPS or SSL Proxy Load Balancers Permit SSL Policies With Weak Cipher Suites
resource "google_compute_ssl_policy" "insecure_ssl_policy" {
  name = "insecure-ssl-policy"
  # default minimum TLS version is 1.0
  # default SSL profile is COMPATIBLE which means trash
}

# 4.2.1 Ensure Legacy Networks Do Not Exist for Older Projects
# Legacy networks can no longer be created and are not recommended for production because they do not support advanced networking features. You can convert a legacy network to a VPC network: https://cloud.google.com/vpc/docs/legacy#single-region-conversion








