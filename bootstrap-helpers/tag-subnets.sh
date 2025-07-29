#!/bin/bash
set -e

CLUSTER_NAME="baas-cluster"
REGION="ap-south-1"

SUBNET_IDS=$(aws ec2 describe-subnets \
  --region $REGION \
  --filters "Name=tag:Name,Values=*private*" \
  --query "Subnets[*].SubnetId" \
  --output text)

echo "🔁 Tagging private subnets for internal load balancer support..."
for subnet_id in $SUBNET_IDS; do
  aws ec2 create-tags --region $REGION --resources $subnet_id --tags \
    Key=kubernetes.io/cluster/$CLUSTER_NAME,Value=owned \
    Key=kubernetes.io/role/internal-elb,Value=1
done