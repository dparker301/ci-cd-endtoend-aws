resource "aws_ecr_repository" "repo" {
  name = var.project_name
  image_scanning_configuration { scan_on_push = true }
  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.repo.repository_url
}
