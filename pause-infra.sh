#!/bin/bash
set -e

# --- Configuration ---
CLUSTER_NAME="baas-cluster"
NODE_GROUP_NAME="default-node-group"
RDS_INSTANCE_ID="baas-rds"
REGION="ap-south-1"

echo "🛑 Stopping RDS instance: $RDS_INSTANCE_ID..."
aws rds stop-db-instance --db-instance-identifier "$RDS_INSTANCE_ID" --region "$REGION"

echo "📉 Scaling down EKS node group '$NODE_GROUP_NAME' to 0 nodes..."
aws eks update-nodegroup-config \
  --cluster-name "$CLUSTER_NAME" \
  --nodegroup-name "$NODE_GROUP_NAME" \
  --scaling-config minSize=0,maxSize=0,desiredSize=0 \
  --region "$REGION"

echo "✅ Pause command issued. It may take a few minutes for resources to stop."
echo "ℹ️ Note: The EKS Control Plane and NAT Gateway will continue to incur costs."