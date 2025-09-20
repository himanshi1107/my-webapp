variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "devops-project"
}

variable "ec2_key_name" {
  description = "Existing EC2 key pair name (for SSH)"
  type        = string
}

variable "github_owner" {
  description = "GitHub username/org owning the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name (e.g. my-webapp)"
  type        = string
}

variable "github_branch" {
  description = "Branch to track"
  default     = "main"
}

variable "github_oauth_token" {
  description = "GitHub personal access token (sensitive)"
  type        = string
  sensitive   = true
}
