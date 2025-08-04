# My SaaS - Core Infrastructure (`infra-core`)

This repository contains the Terraform code to provision and manage the core AWS infrastructure for the "My SaaS" platform. It creates a production-grade environment based on Amazon EKS, VPC, and RDS, designed with a focus on modularity, state separation, and cost management.

## 🏛️ Architecture Philosophy

The infrastructure is intentionally divided into multiple, independently-managed Terraform stacks. This design choice is crucial for stability and cost-effectiveness.

* **`remote-backend-infra/`**: This is a one-time setup stack. It provisions the **S3 bucket** and **DynamoDB table** that Terraform itself uses to store its state file remotely and manage state locks. This is essential for collaborative, safe infrastructure management.
* **`destroyable-stack/`**: This stack contains all the *stateless* or *ephemeral* resources. This includes the **VPC, subnets, NAT Gateway, and the EKS cluster itself (control plane and node groups)**. Because these resources don't hold critical, long-term data, this entire stack can be safely destroyed and recreated without data loss.
* **`shared-resources/`**: This stack manages the *stateful* components of our platform. Primarily, this is the **PostgreSQL RDS instance**. By keeping it in a separate stack, we can tear down the entire EKS cluster and VPC for cost savings while our database and its data remain safe and untouched. It reads outputs from the `destroyable-stack` (like VPC and subnet IDs) to place itself in the correct network.

## 💰 Cost Management Strategy

This project is designed to be **cost-aware**. The most expensive components (EKS worker nodes and the RDS instance) can be stopped without being destroyed.

* **Pausing:** We use scripts to scale the EKS node group to 0 and stop the RDS instance. This is the recommended daily workflow to save money. The EKS control plane (~₹7,000/month) and NAT Gateway will continue to incur costs, but this is a fraction of the full running cost.
* **Destroying:** `terraform destroy` is a "nuke" option for the `destroyable-stack`. It's used when you want to tear down the VPC and EKS cluster completely, not for daily pauses.

---

## 📋 Prerequisites

Before you begin, ensure you have the following tools installed and configured:

1.  **Terraform CLI** (`>= 1.0`)
2.  **AWS CLI** (`>= 2.0`)
3.  **`kubectl`**
4.  **Configured AWS Credentials:** Your AWS CLI should be configured with an IAM user that has `AdministratorAccess`. You can do this by running `aws configure`.

---

## 🚀 Getting Started: Step-by-Step Instructions

Follow these steps in order to provision the environment.

### 1. First-Time Setup: Provision the Terraform Backend

This step only needs to be done once for the entire project.

```bash
# Navigate to the backend infrastructure directory
cd remote-backend-infra/

# Initialize Terraform to download providers
terraform init

# Create the S3 bucket and DynamoDB table
terraform apply
```


### 2. Provision the Main Environment
Now, create the VPC, EKS cluster, and RDS instance. The order is important.

```bash
# 1. Provision the VPC and EKS Cluster
cd ../destroyable-stack/
terraform init
terraform apply

# 2. Configure kubectl to connect to your new cluster
# This command is an output from the previous step
aws eks update-kubeconfig --name baas-cluster --region ap-south-1

# 3. Verify connection
kubectl get nodes

# 4. Provision the RDS Database
cd ../shared-resources/
terraform init
terraform apply
```
At this point, your entire infrastructure is running.

workday Workflow: Pausing and Resuming
To manage costs, use these scripts located in the root of the repository.

Pausing the Infrastructure
This command scales the EKS worker nodes to zero and stops the RDS instance.


```bash
./pause-infra.sh
```


### Resuming the Infrastructure
This command starts the RDS instance and scales the EKS nodes back to their configured capacity.

```bash
./resume-infra.sh

```

Note: It may take several minutes for the RDS instance to become available and for the EKS nodes to join the cluster.

💣 Complete Teardown
If you need to completely remove all resources (including the database), run destroy on each stack in the reverse order of creation.




```bash

# 1. Destroy the RDS instance first
cd shared-resources/
terraform destroy

# 2. Destroy the EKS cluster and VPC
cd ../destroyable-stack/
terraform destroy

# (Optional) If you want to remove the backend itself
cd ../remote-backend-infra/
terraform destroy
```


