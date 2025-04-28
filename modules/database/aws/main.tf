resource "aws_db_subnet_group" "private" {
  name       = "${var.environment}-private-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name        = "${var.environment}-private-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "app_db" {
    allocated_storage    = 20
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    db_name              = var.db_name
    username             = var.db_username
    password             = var.db_password
    db_subnet_group_name = aws_db_subnet_group.private.name
    vpc_security_group_ids = [var.rds_sg_id]
    skip_final_snapshot  = true
    publicly_accessible  = false
    storage_encrypted    = true
    backup_retention_period = 7
    delete_automated_backups = true

    tags = {
        Name        = "${var.environment}-app-db"
        Environment = var.environment
    }
}