terraform {
  backend "s3" {
    bucket         = "app-staging-bucket"  
    key            = "staging/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    use_lockfile   = true  
  }
}

module "network" {
  source          = "../../modules/network/aws"
  environment     = var.environment
  app_name = var.app_name
}

module "security" {
  source          = "../../modules/security/aws"
  environment     = var.environment
  vpc_id          = module.network.vpc_id
}

module "database" {
  source          = "../../modules/database/aws"
  environment     = var.environment
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
  private_subnets = module.network.private_subnets
  rds_sg_id       = module.security.rds_sg_id
}

resource "aws_ssm_parameter" "db_endpoint" {
  name        = "/${var.environment}/db_environment"
  description = "Database endpoint for ${var.environment} environment"
  type        = "String"
  value       = module.database.rds_endpoint
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.environment}/db_username"
  description = "Database username for ${var.environment} environment"
  type        = "String"
  value       = var.db_username
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.environment}/db_password"
  description = "Database password for ${var.environment} environment"
  type        = "SecureString"
  value       = var.db_password
}

module "compute" {
  source          = "../../modules/compute/aws"
  environment     = var.environment
  instance_type = var.instance_type
  app_ami_id    = var.ec2_ami_id
  subnet_id = module.network.public_subnet_id
  sg_id = module.security.app_sg_id
  key_name = module.security.key_name
}