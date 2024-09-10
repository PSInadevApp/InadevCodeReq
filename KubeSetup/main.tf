module "vpc" {
	source = "terraform-aws-modules/vpc/aws"
	
	name = "inadev_psapp_vpc"
	cidr = var.vpc_cidr
	
	azs = data.aws_availability_zones.azs.names
	public_subnets = var.public_subnets
    private_subnets = var.private_subnets

	enable_dns_hostnames = true
    enable_nat_gateway = true
    single_nat_gateway = true

    tags = {
        "kubernetes.io/cluster/inadev_psapp_cluster" = "shared"
    }

    public_subnet_tags = {
        "kubernetes.io/cluster/inadev_psapp_cluster" = "shared"
            "kubernetes.io/role/elb" = 1
    }
    private_subnet_tags = {
        "kubernetes.io/cluster/inadev_psapp_cluster" = "shared"
            "kubernetes.io/role/private_elb" = 1
    }
}

#EKS

module "eks" {
	source = "terraform-aws-modules/eks/aws"
	cluster_name = "inadev_psapp_cluster" 
	cluster_version = "1.30"
	cluster_endpoint_public_access = true
	vpc_id = module.vpc.vpc_id
    subnet_ids = var.vpc.private_subnets

	eks_managed_node_groups = {
		eks_nodes = {
            min_size = 1
            max_size = 3
            desired_size = 2
			instance_types = var.instance_types
		}
	}
    tags = {
        Environment = "dev"
        Terraform = "true"
    }
}