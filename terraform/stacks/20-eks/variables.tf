variable "region" {
    description = "AWS region"
    type = string
    default = "us-east-1"
}
variable "cluster_name" { type = string }
variable "cluster_version" { type = string default = "1.30" }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }


variable "node_desired" { type = number default = 3 }
variable "node_min" { type = number default = 3 }
variable "node_max" { type = number default = 6 }
variable "node_instance_types" { type = list(string) default = ["m6i.xlarge"] }
variable "node_capacity_type" { type = string default = "ON_DEMAND" }


variable "tags" { type = map(string) default = {} }