resource "aws_codedeploy_app" "app" {
  name             = "${var.project_name}-codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "dg" {
  app_name              = aws_codedeploy_app.app.name
  deployment_group_name = "${var.project_name}-dg"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "${var.project_name}-app-instance"
    }
  }

  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
