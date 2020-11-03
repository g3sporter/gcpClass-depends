variable "image" {
  default = "ubuntu-os-cloud/ubuntu-1604-lts"
}
variable "machine_type" {
  type = map
  default = {
    dev  = "n1-standard-1"
    test = "n2-standard-2"
    prod = "n2-standard-4"
  }
}
variable "zone" {
  default = "us-west1-a"
}
variable "name_count" {
  default = ["server1", "server2", "server3"]
}
variable "env" {
  default = "prod"
}
