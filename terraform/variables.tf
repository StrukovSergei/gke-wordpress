variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
  default = "gke-wordpress-440211"
}

variable "region" {
  description = "Region where resources will be deployed"
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "Zone where resources will be deployed"
  type        = string
  default     = "europe-central2-a"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "wordpress-gke-cluster"
}

variable "master_version" {
  description = "Master version of the GKE cluster"
  type        = string
  default     = "1.28"
}

variable "node_pool_name" {
  description = "Name of the GKE node pool"
  type        = string
  default     = "wordpress-node-pool"
}

variable "initial_node_count" {
  description = "Initial number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "node_machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "sql_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
  default     = "wordpress-sql-instance"
}

variable "database_version" {
  description = "Version of the Cloud SQL database"
  type        = string
  default     = "MYSQL_8_0"
}

variable "sql_tier" {
  description = "Tier (machine type) for the SQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "sql_database_name" {
  description = "Name of the Cloud SQL database"
  type        = string
  default     = "wordpress_db"
}

variable "sql_username" {
  description = "Username for Cloud SQL database"
  type        = string
  default     = "wordpress"
}

variable "sql_password" {
  description = "Password for Cloud SQL database user"
  type        = string
  sensitive   = true
}

variable "deletion_protection" {
  description = "Enable deletion protection on the SQL instance"
  type        = bool
  default     = false
}