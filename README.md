# terraform-gke

A simple terraform configuration for deployment of a Kubernetes cluster on the Google Cloud Platform using the GKE module

# Contents

gke.tf --> Contains the resource definitions for provisioning a gke cluster and a node pool in the cluster

vpc.tf --> Resource definition for creating a VPC network for the cluster

versions.tf --> Version definitions for Terraform and providers for GKE

variables.tf --> Variable definitions

monitoring_alerts.tf --> resource definition for a few basic alert configurations in GCP

notification_channel.tf --> email notification channel definition for the alerts

deployment/test.tfvars --> variable values for test deployment
