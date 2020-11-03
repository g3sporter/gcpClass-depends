provider "google" {
 #credentials = "${file("/Users/bryan/hashicorp/bryanTest-d87f1249d43c.json")}"
 project     = "bryantest"
 region      = "us-west1"
}

resource "google_compute_instance" "default" {
  #count        = "${length(var.name_count)}"
  count        = length(var.name_count)
  name         = "list-${count.index + 1}"
  machine_type = var.machine_type[var.env]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
 # Changes the order of build## 
 depends_on = [google_compute_instance.primary]
}

resource "google_compute_instance" "primary" {
  #count        = "${length(var.name_count)}"
  count        = "1"
  name         = "primary"
  machine_type = var.machine_type[var.env]
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

}



output "GCP_Instance_Type" { value = "${google_compute_instance.default.*.machine_type}" }
output "GCP_Instance_Name" { value = "${google_compute_instance.default.*.name}" }
output "GCP_Instance_Zone" { value = "${google_compute_instance.default.*.zone}" }
#make the output comma seperated for use as a variable
output "instance_id" { value = "${join(",", google_compute_instance.default.*.name)}" }
