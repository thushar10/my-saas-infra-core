#!/bin/bash
cd "$(dirname "$0")/.."

echo "🔥 Destroying EKS, NAT, VPC (RDS stays safe in shared-resources)"
terraform destroy -auto-approve