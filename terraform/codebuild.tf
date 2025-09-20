resource "aws_codebuild_project" "app_build" {
  name          = "${var.project_name}-build"
  service_role  = aws_iam_role.codebuild_role.arn
  description   = "Build Docker image and push to ECR"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true  # Required for Docker builds

    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.app.repository_url
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
