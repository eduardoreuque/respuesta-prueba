resource "aws_iam_instance_profile" "nodes_profile"{
  name = "${var.project_name}-${var.environment}"
  role = aws_iam_role.nodes.name
}
resource "aws_iam_role" "server_role" {
  name = "server-role"
  path = "/"
  
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

  EOF
  
  }
  
  resource "aws_iam_policy_attachment" "attachment1" {
      name     = "attachment1"
	  roles    = [aws_iam_role.nodes.name]
	  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
   
   resource "aws_iam_policy_attachment" "attachment2" {
      name     = "attachment2"
	  roles    = [aws_iam_role.nodes.name]
	  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  }
  
  resource "aws_iam_policy_attachment" "attachment3" {
      name     = "attachment3"
	  roles    = [aws_iam_role.nodes.name]
	  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  }
  
  resource "aws_iam_policy_attachment" "attachment4" {
      name     = "attachment4"
	  roles    = [aws_iam_role.nodes.name]
	  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  }
  