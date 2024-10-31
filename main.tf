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

resource "google_sql_database_instance" "wordpress_db_instance" {
  name             = "wordpress-sql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

# Define the database
resource "google_sql_database" "wordpress_database" {
  name     = "wordpress_db"
  instance = google_sql_database_instance.wordpress_db_instance.name
}

# Define the database user
resource "google_sql_user" "wordpress_user" {
  name     = "wordpress"
  instance = google_sql_database_instance.wordpress_db_instance.name
  password = "test123"  # Replace with a secure password
}
