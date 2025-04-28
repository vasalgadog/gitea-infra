output "instance_public_ip" {
    description = "Public IP of the EC2 instance"
    value = module.compute.instance_public_ip
}

output "db_endpoint" {
    description = "Endpoint of the RDS instance without the port"
    value = split(":", module.database.rds_endpoint)[0]
}