#AWS provider
provider "aws" {
  region = var.aws_region
}

#Creation policy for role
resource "aws_iam_role_policy" "test" {
  name = var.role_name
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "eks:DeleteCluster",
                "eks:UpdateClusterVersion",
                "eks:UpdateClusterConfig",
                "eks:CreateCluster"
            ]
            "Resource": "*"
        }
    ]

    
  })
}

#creation of role

resource "aws_iam_role" "role" {
  name = var.role_name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::738087856818:user/EKS-User"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
EOF
}

resource "aws_iam_user" "user" {
  name = var.user_name
}


