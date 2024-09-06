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

/*output "pvt_alb" {
  value = aws_lb.noise-aws-alb-private.arn
}*/

/*output "pub_alb" {
  value = aws_lb.noise-aws-alb-public.arn
}*/
/*output "pvt_alb_lister_443_arn" {
  value = aws_lb_listener.private_443.arn
}*/

/*output "pub_alb_lister_443_arn" {
  value = aws_lb_listener.public_443.arn
}*/

/*output "pvt_alb_name" {
  value = aws_lb.noise-aws-alb-private.dns_name
}
output "pub_alb_name" {
  value = aws_lb.noise-aws-alb-public.dns_name
}*/