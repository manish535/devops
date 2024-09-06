# Output reguired by dependent modules
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "private_subnet" {
  value = module.vpc.private_subnets
}
output "alb_security_group_id" {
  value = aws_security_group.alb.id
}