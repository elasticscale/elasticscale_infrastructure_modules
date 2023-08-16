output "codestar_connection_arn" {
  value = aws_codestarconnections_connection.codestar.arn
}

output "image_base_url" {
  value = module.ecs_dockerhub_clone.image_base_url
}