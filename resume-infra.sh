#!/bin/bash
set -e

# --- Configuration ---
CLUSTER_NAME="baas-cluster"
NODE_GROUP_NAME="default-node-group"
RDS_INSTANCE_ID="baas-rds"
REGION="ap-south-1"

# --- Terraform variables (for resuming to the correct size) ---
DESIRED_CAPACITY=1
MIN_SIZE=1
MAX_SIZE=1

echo "▶️ Starting RDS instance: $RDS_INSTANCE_ID..."
aws rds start-db-instance --db-instance-identifier "$RDS_INSTANCE_ID" --region "$REGION"

echo "📈 Scaling up EKS node group '$NODE_GROUP_NAME' to desired capacity..."
aws eks update-nodegroup-config \
  --cluster-name "$CLUSTER_NAME" \
  --nodegroup-name "$NODE_GROUP_NAME" \
  --scaling-config minSize=$MIN_SIZE,maxSize=$MAX_SIZE,desiredSize=$DESIRED_CAPACITY \
  --region "$REGION"

echo "✅ Resume command issued. It may take a few minutes for nodes to become ready."
echo "🔎 Run 'kubectl get nodes' to check status."