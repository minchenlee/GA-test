################################################
# Security group
################################################

# Security group for backend instance
resource "aws_security_group" "backend-instance" {
  name        = "thesis-backend-instance"
  description = "Security group for thesis backend instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow All TCP traffic from port 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Belong    = var.belong_tag
    CreatedBy = "Terraform"
  }
}
