resource "google_compute_network" "vpc_network" {
  name = "ctfd-vpc"
  auto_create_subnetworks = true
}

resource "google_container_cluster" "primary" {
  name     = "ctfd-cluster"
  location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  network = google_compute_network.vpc_network.id
  managed_prometheus = true
  enable_autopilot = true
}