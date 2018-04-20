
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all HTTP/HTTPS traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "vpc" {
  source	       = "terraform-aws-modules/vpc/aws"
  name                 = "test-aurora"
  cidr            = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  azs                  = ["ap-southeast-2a","ap-southeast-2b"]
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_private_subnet_ids" {
  value = ["${module.vpc.private_subnets}"]
}

output "vpc_public_subnet_ids" {
  value = ["${module.vpc.public_subnets}"]
}
