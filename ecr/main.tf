provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "quest_app_repo" {
  name                 = "quest-app-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.quest_app_repo.repository_url
}
