resource "aws_ecr_repository" "quest_app_repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = var.repository_name
  }
}

output "repository_url" {
  value = aws_ecr_repository.quest_app_repo.repository_url
}
