resource "aws_ecs_cluster" "red" {
  name = "red-hevean-devil"

}

resource "aws_ecs_service" "red" {
  name    = "red"
  cluster = aws_ecs_cluster.red.id

  task_definition = aws_ecs_task_definition.red.family

  desired_count = var.task_count

  launch_type = "FARGATE"

  health_check_grace_period_seconds = 15



  network_configuration {
    subnets          = data.aws_subnets.public_subnets.ids
    security_groups  = [aws_security_group.kartik_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.red-target.arn
    container_name   = "red-target"
    container_port   = 5000

  }
  depends_on = [aws_lb_listener.lb-listener]
}




resource "aws_ecs_task_definition" "red" {
  family                   = "attendance"
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-task-role.arn
  requires_compatibilities = [ "FARGATE" ]
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "red-target"
      image = "${data.aws_ecr_repository.attendance-app.repository_url}@${data.aws_ecr_image.latest.image_digest}"

      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [{
        containerPort = 5000
        
        protocol      = "tcp"
      }]
    }
  ])


}