#!/bin/bash

# Exit on any error
set -e
trap 'echo "An error occurred. Exiting."' ERR

# Define variables
CLUSTER_NAME="wordpress-gke-cluster"
REGION="europe-central2"
PROJECT_ID="gke-wordpress-440211"
SQL_KEY_PATH="/home/sergei/wordpress-sql-key.json"
TLS_CERT_PATH="tls.crt"
TLS_KEY_PATH="tls.key"
DEPLOYMENT_YAML="wordpress-deployment.yaml"
HPA_YAML="wordpress-HPA.yaml"
SERVICE_YAML="wordpress-service.yaml"
INGRESS_YAML="wordpress-ingress.yaml"
NGINX_DEPLOY_URL="https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0-beta.0/deploy/static/provider/cloud/deploy.yaml"

echo "Authenticating with GKE cluster..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region="$REGION" --project="$PROJECT_ID"

echo "Creating Cloud SQL service account secret..."
kubectl create secret generic cloud-sql-sa-key --from-file=key.json="$SQL_KEY_PATH"

echo "Creating TLS secret..."
kubectl create secret tls wordpress-tls --cert="$TLS_CERT_PATH" --key="$TLS_KEY_PATH"

echo "Applying WordPress deployment..."
kubectl apply -f "$DEPLOYMENT_YAML"

sleep 20

echo "Applying Horizontal Pod Autoscaler..."
kubectl apply -f "$HPA_YAML"

echo "Applying WordPress service..."
kubectl apply -f "$SERVICE_YAML"

sleep 30

echo "Deploying NGINX Ingress controller..."
kubectl apply -f "$NGINX_DEPLOY_URL"

sleep 180

echo "Applying WordPress Ingress configuration..."
kubectl apply -f "$INGRESS_YAML"

sleep 30

echo "Fetching ingress details..."
kubectl get ingress wordpress-ingress

echo "All steps completed successfully."
