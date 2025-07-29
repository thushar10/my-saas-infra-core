#!/bin/bash
set -e

CLUSTER_NAME="baas-cluster"
REGION="ap-south-1"

echo "🔁 Associating OIDC provider for EKS cluster: $CLUSTER_NAME"
eksctl utils associate-iam-oidc-provider --region $REGION --cluster $CLUSTER_NAME --approve