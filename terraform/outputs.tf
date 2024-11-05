output "kubernetes_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}

output "kubernetes_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}

output "db_instance_name" {
  description = "The name of the Cloud SQL instance"
  value       = google_sql_database_instance.wordpress_db_instance.name
}

output "db_ip_address" {
  description = "The IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.wordpress_db_instance.public_ip_address
}