terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_container_cluster" "gke_cluster" {
  name     = "wordpress-gke-cluster"
  location = var.region

  initial_node_count = 1
  min_master_version = "1.28"

  remove_default_node_pool = true
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "wordpress-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region

  node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}