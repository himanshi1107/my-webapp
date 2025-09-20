output "ecr_repo_url" {
  value = aws_ecr_repository.app.repository_url
}
output "pipeline_name" {
  value = aws_codepipeline.pipeline.name
}
output "ec2_public_ip" {
  value = aws_instance.app.public_ip
  description = "Public IP of the EC2 instance running app (after apply)"
}
