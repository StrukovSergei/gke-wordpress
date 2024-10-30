output "kubernetes_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}

output "kubernetes_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.gke_cluster.endpoint
}
