output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "List of IDs of public subnets"
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "List of IDs of private subnets"
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "The CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "The ID of the Internet Gateway"
}

output "nat_gateway_ids" {
  value       = aws_nat_gateway.nat[*].id
  description = "List of IDs of the NAT Gateways"
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public route table"
}

output "private_route_table_ids" {
  value       = [aws_route_table.private.id]
  description = "List of IDs of the private route tables"
}
