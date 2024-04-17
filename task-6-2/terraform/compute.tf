# ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}


# backend instance a
resource "aws_instance" "backend-a" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "task-0-1-a"
  vpc_security_group_ids      = [aws_security_group.backend-instance.id]
  subnet_id                   = "subnet-0e3f1389d5169d7d3"
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo snap install docker
              EOF

  tags = {
    Belong    = var.belong_tag
    CreatedBy = "Terraform"
  }
}

