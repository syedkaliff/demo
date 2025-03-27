output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet1_id" {
  value = aws_subnet.private1.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
