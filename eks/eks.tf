provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA4HY2YYK3X2MU6RND"
  secret_key = "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"
}

data "aws_eks_cluster" "cluster"{
  name = module.my-cluster.cluster_id
  }
data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
  }

provider "kubernetes" {
    host                   = data.aws_eks_cluster.cluster.endpoint
	cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
	token                  = data.aws_eks_cluster_auth.cluster.token
	load_config_file       = false
	version = "~> 18.0"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "Cluster-Kubernetes"
  cluster_version = "1.22"
  subnet_ids     = ["subnet-0d901996c452091fd", "subnet-07c5ec9f9107971ce", "subnet-07c5ec9f9107971ce"]
  vpc_id          = "vpc-0296ea937535c8e08"
  
   self_managed_node_groups = {
   
        name = "nodes1"
		iam_role_arn = ["aws_iam_role.nodes.arn"]
		max_capacity = 5
		min_capacity = 1
		desired_capacity = 1
		instance_types = ["t3.large"]
    
  }
  }
 
  
  