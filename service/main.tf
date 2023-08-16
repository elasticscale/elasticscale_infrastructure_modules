
resource "aws_ecs_task_definition" "taskdef" {
  family                   = "${var.prefix}-taskdef"
  container_definitions    = var.container_definitions
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  // an example on how you can dynamically set the cpu and memory based on the environment
  cpu    = var.is_production ? 256 : 1024
  memory = var.is_production ? 512 : 2048
}

resource "aws_security_group" "egress" {
  name   = "${var.prefix}-${var.service_name}-sg"
  vpc_id = var.vpc_id
  // could add dynamic ingress blocks to the service module via parameters
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "service" {
  name                 = "${var.prefix}-${var.service_name}"
  cluster              = var.cluster_name
  task_definition      = aws_ecs_task_definition.taskdef.arn
  desired_count        = var.is_production ? 3 : 1
  force_new_deployment = false
  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 100
  }
  network_configuration {
    subnets = var.subnets
    security_groups = [
      aws_security_group.egress.id
    ]
    assign_public_ip = false
  }
}

// this module would normally also create the execution roles and task roles