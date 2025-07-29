# EKS Bootstrap Helpers

These scripts handle one-time setup tasks that aren't managed by Terraform directly, but are required to run workloads properly on a newly created EKS cluster.

## 🔧 What This Does

- ✅ Associates an OIDC provider with the EKS cluster (needed for IAM roles for service accounts)
- ✅ Tags private subnets so services like ArgoCD or internal apps can use AWS LoadBalancers
- ✅ Patches the aws-auth ConfigMap to give your IAM user `kubectl` access

## ✅ When to Run

Run this after running Terraform (in `destroyable-stack/`) to bring up EKS:

```bash
cd bootstrap-helpers/
make bootstrap
