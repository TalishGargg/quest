data "aws_ecr_repository" "quest_app_repo" {
  name = "quest-app-repo"
}

data "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
}
