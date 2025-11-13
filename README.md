# clickhouse-aws

Infrastructure-as-Code demo that provisions an AWS footprint for highly available ClickHouse using Terraform. The repo mirrors how I typically split responsibilities into reusable modules and environment-specific stacks:

- **00-backend** - Sets up a S3 backend remote state with DynamoDB locking.
- **10-networking** – Regional VPC with three AZs, public/private subnets, NAT gateway, and Kubernetes-aware tags.
- **20-eks** – Production-ready Amazon EKS cluster with managed node groups sized for steady-state analytics workloads.
- **30-clickhouse** – Installs the Altinity ClickHouse Operator via Helm and bootstraps a sharded ClickHouseInstallation custom resource.


## Repository layout

```
terraform/
├── modules/
│   ├── vpc          # thin wrapper over terraform-aws-modules/vpc
│   ├── eks          # thin wrapper over terraform-aws-modules/eks
│   └── clickhouse   # Helm + CRD automation for Altinity operator
├── stacks/
|   ├── 00-backend
│   ├── 10-networking
│   ├── 20-eks
│   └── 30-clickhouse
└── examples/        # sample tfvars for each stack
```


## Prerequisites

- Terraform ≥ 1.13.4
- AWS credentials with permissions for VPC, IAM, EKS, and EBS
- Remote state backend (provision via `terraform/stacks/00-backend` or point to an existing S3 bucket + DynamoDB table)
- `kubectl` and `aws` CLIs for post-provision validation

## Deploying the environment

0. **Backend (optional)** – bootstrap the remote state bucket and lock table if you don't already have them.

   ```bash
   cd terraform/stacks/00-backend
   terraform init
   terraform apply -var-file ../../examples/00-backend.tfvars
   ```

1. **Networking** – builds the shared VPC and outputs subnet IDs.

   ```bash
   cd terraform/stacks/10-networking
   terraform init
   terraform apply -var-file ../../examples/10-networking.tfvars
   ```

2. **EKS** – automatically consumes the networking outputs via remote state (override the `network_state_*` variables if your bucket/key differ).

   ```bash
   cd ../20-eks
   terraform init
   terraform apply -var-file ../../examples/20-eks.tfvars
   ```

3. **ClickHouse** – targets the existing EKS cluster and installs the operator plus a two-shard / two-replica installation with gp3-backed volumes.

   ```bash
   cd ../30-clickhouse
   terraform init
   terraform apply -var-file ../../examples/30-clickhouse.tfvars
   ```

   The `ClickHouseInstallation` is templated for predictable HA characteristics:

   - Multi-AZ shards spread across the managed node group
   - Dedicated gp3 EBS volumes per replica (`200Gi` by default)
   - Resource requests/limits suitable for production (1 vCPU/4 GiB request, 2 vCPU/8 GiB limit)

## Operating the stack

After the ClickHouse stack finishes you can validate the deployment:

```bash
aws eks update-kubeconfig --name clickhouse-demo --region us-east-1
kubectl get pods -n clickhouse
kubectl get chi -n clickhouse
```

Expose a SQL endpoint for local testing:

```bash
kubectl port-forward svc/chi-analytics 9000:9000 -n clickhouse
clickhouse-client --host 127.0.0.1 --secure --user default
```

Backups and DR can be layered on using ClickHouse object storage replication or incremental backups to S3. Because the statefulset relies on EBS volumes with a `Retain` reclaim policy, node failures do not destroy data. Restoring into a new AZ only requires re-attaching volumes via the operator.

## Customization ideas

- Override `node_instance_types` in `20-eks` for cost-optimized Spot pools.
- Adjust `shards`, `replicas`, and `disk_size` to model different tenant footprints.
- Pass tolerations/affinity via `30-clickhouse` variables to isolate workloads onto storage-optimized nodes.
- Wire the stacks into Atlantis/Spacelift and trigger automated `plan` checks on pull requests.

