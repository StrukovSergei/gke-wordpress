terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
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

# GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.initial_node_count
  min_master_version = var.master_version
  remove_default_node_pool = true
}

# Node Pool Configuration
resource "google_container_node_pool" "gke_node_pool" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.initial_node_count

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Cloud SQL Instance Configuration with Private IP
resource "google_sql_database_instance" "wordpress_db_instance" {
  name             = var.sql_instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.sql_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
    }
  }

  deletion_protection = var.deletion_protection
}

# Database Definition
resource "google_sql_database" "wordpress_database" {
  name     = var.sql_database_name
  instance = google_sql_database_instance.wordpress_db_instance.name
}

# Database User
resource "google_sql_user" "wordpress_user" {
  name     = var.sql_username
  instance = google_sql_database_instance.wordpress_db_instance.name
  password = var.sql_password
}
