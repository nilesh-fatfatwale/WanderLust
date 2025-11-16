resource "aws_key_pair" "KeyPair" {
  key_name   = "wanderlust"
  public_key = file("wanderlust.pub")
}

resource "aws_default_vpc" "Vpc" {}

resource "aws_security_group" "name" {
  vpc_id = aws_default_vpc.Vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open 22 port for ssh"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port for http"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port for https"
  }
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port NodePort"
  }
  ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port SMTP"
  }
  ingress {
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port SMTPS"
  }
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port Redis"
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open port K8s"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all port for outbound"
  }
  tags = {
    Name = "WanderLust-MegaProject-SG"
  }
}


resource "aws_instance" "Instance" {
  ami                    = var.ami
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.KeyPair.key_name
  vpc_security_group_ids = [aws_security_group.name.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
  tags = {
    Name = "WanderLust-MegaProject"
  }
}
