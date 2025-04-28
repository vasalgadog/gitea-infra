output "app_sg_id" {
    value = aws_security_group.app.id
    description = "Security group ID for the application"
}

output "rds_sg_id" {
    value = aws_security_group.rds.id
    description = "Security group ID for the RDS instance"
}

output "key_name" {
    value = aws_key_pair.generated_key.key_name
    description = "Name of the generated key pair"
}