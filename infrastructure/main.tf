// this creates some required resources for our infrastructure account

resource "aws_codestarconnections_connection" "codestar" {
  name          = "${var.prefix}-conn"
  provider_type = var.provider_type
}

module "ecs_dockerhub_clone" {
  source    = "elasticscale/ecs-dockerhub-clone/aws"
  version   = "3.0.2"
  prefix    = "${var.prefix}-clone-"
  namespace = "dockerhub"
  containers = {
    "devopsinfra/docker-terragrunt" = ["aws-tf-1.5.5-tg-0.50.1"],
    "aquasec/tfsec"                 = ["v1.28"]
  }
  docker_hub_access_token = var.docker_hub_access_token
  docker_hub_username     = var.docker_hub_username
}
