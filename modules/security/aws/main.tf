data "http" "current_ip" {
  url = "http://checkip.amazonaws.com/"
}

resource "aws_security_group" "app" {
    name = "${var.environment}-app-sg"
    vpc_id = var.vpc_id
    description = "Security group for the application"
    tags = {
        Name = "${var.environment}-app-sg"
        Environment = var.environment
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
        description = "Allow HTTP traffic"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks  = ["${chomp(data.http.current_ip.body)}/32"]
        description = "Allow SSH traffic"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}

resource "aws_security_group" "rds" {
    name = "${var.environment}-rds-sg"
    vpc_id = var.vpc_id
    description = "Security group for the RDS instance"
    tags = {
        Name = "${var.environment}-rds-sg"
        Environment = var.environment
    }

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.app.id]
        description = "Allow MySQL traffic from app security group"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
}

resource "tls_private_key" "privateKey" {
    algorithm = "RSA"
    rsa_bits = 2048
}

resource "aws_key_pair" "generated_key" {
    key_name   = "${var.environment}-key"
    public_key = tls_private_key.privateKey.public_key_openssh
    tags = {
        Name = "${var.environment}-key"
        Environment = var.environment
    }
}

resource "local_file" "private_key_pom" {
  content = tls_private_key.privateKey.private_key_pem
  filename = "./gitea-appkey.pem"
  file_permission = "0400"
}