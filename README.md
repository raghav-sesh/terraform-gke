# terraform-gke

A simple terraform configuration for deployment of a Kubernetes cluster on the Google Cloud Platform using the GKE module

# Contents

> gke.tf --> Contains the resource definitions for provisioning a gke cluster and a node pool in the cluster
>
> vpc.tf --> Resource definition for creating a VPC network for the cluster
>
> versions.tf --> Version definitions for Terraform and providers for GKE
>
> variables.tf --> Variable definitions
>
> monitoring_alerts.tf --> resource definition for a few basic alert configurations in GCP
>
> notification_channel.tf --> email notification channel definition for the alerts
>
> deployments/test.tfvars --> variable values for test deployment


# External Resources
Repo for kubernetes deployment yaml configuration files at __link__

# Prerequisites
> GCP account
> 
> gcloud sdk setup
> 
> kubectl and kubectx setup

For detailed steps to setup prerequisites, visit: https://learn.hashicorp.com/tutorials/terraform/gke?in=terraform/kubernetes#kubectl


# The Terraform configuration
This projects provisions a simple gke cluster in us-central1 region as defined in deployment/test.tfvars

A basic node pool is created with machines of type e2-micro (the simplest machine type)

Disk configuration for the node pool is done with default settings of a standard disk of 10 GB size

# Autoscaling
Autoscaling can be enabled/disabled with the enable_autoscaling variable. 

The default autoscaling min/max are 2/5 nodes correspondingly

# Monitoring & Alerts
Here we use GCP's stock monitoring and alerting service - Stack Driver, to monitor cluster parameters of interest and raise alerts accordingly.

More detailed monitoring can be done by using resources like GCP's BigQuery, which can monitor required resources at required intervals extensively for a cost.

As a sample, two alerts have been configured in the monitoring_alerts.tf

>CPU allocatable utilization alert

This alert is raised when the node pool's cpu utilization reaches a threshold.

To simulate this alert, it is configured to be triggered on the event when CPU usage reaches as low as 0.01, i.e, 1% of max cpu usage


>Memory allocatable utilization alert

This alert is raised when the node pool's memory utilization reaches a threshold.

To simulate this alert, it is configured to be triggered on the event when memory usage reaches as low as 0.001, i.e, 0.1% of max mem usage

# Alert notification
An email notification has been configured in notification_channel.tf to send mails on  the event of any alert. 
Here is a sample alert email:

![Screenshot 2021-08-22 at 9 20 16 PM](https://user-images.githubusercontent.com/22592043/130389601-27fc1752-4b87-43a7-9d27-31ee8ec7b3c7.png)


# How to run
1. Setup gcloud and authenticate to your GCP account
>gcloud init
>
>gcloud auth application-default login

2. Select the correct GCP project
>gcloud config set project project-name


3. Edit Terraform variables in deployments/test.tfvars as applicable.

4. Apply the Terraform configuration to provision the cluster.

>terraform init
>
>terraform apply -var-file=./deployments/test.tfvars
>

This should create the GKE cluster as shown below. The cluster can be verified in the GCP project dashboard by navigating to Kubernetes Engine -> Clusters

![Screenshot 2021-08-22 at 10 14 22 PM](https://user-images.githubusercontent.com/22592043/130393900-351db218-f23f-4445-bb90-60763874a604.png)

![Screenshot 2021-08-22 at 10 13 23 PM](https://user-images.githubusercontent.com/22592043/130393856-94e6d5e0-e9c6-4f9b-bb9b-390726436ba3.png)

Since the default alerts have been configured with very low thresholds, both alerts should get triggered right after allocation of the cluster and email is sent as shown in the screenshot above.

For further steps on deployment of kubernetes pods, please follow steps mentioned in the other github repo --> 
