# 1.3.4 Ensure "Block Project-Wide SSH Keys" Is Enabled for VM Instances
# 1.5.1 Ensure That IP Forwarding Is Not Enabled on Instances
resource "google_compute_instance" "insecure_vm" {
  name           = "insecure-vm"
  machine_type   = "e2-medium"
  zone           = "us-east1-c"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2210-kinetic-amd64-v20230126"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    serial-port-logging-enable = "TRUE"
    serial-port-enable         = "TRUE"
  }
}

# 1.7.1 Ensure 'Enable Connecting to Serial Ports' Is Not Enabled for VM Instance
data "google_compute_instance_serial_port" "serial" {
  instance = google_compute_instance.insecure_vm.name
  zone     = google_compute_instance.insecure_vm.zone
  port     = 4
}

output "serial_out" {
  value = data.google_compute_instance_serial_port.serial.contents
}
