resource "aws_s3_bucket" "artifact_bucket" {
  bucket         = "${var.project_name}-artifacts-${random_id.suffix.hex}"
  force_destroy  = true
}

resource "aws_s3_bucket_acl" "artifact_bucket_acl" {
  bucket = aws_s3_bucket.artifact_bucket.id
  acl    = "private"
}
