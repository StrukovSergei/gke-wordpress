variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
  default = "gke-wordpress-440211"
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where resources will be deployed"
  type        = string
  default     = "us-central1-a"
}
