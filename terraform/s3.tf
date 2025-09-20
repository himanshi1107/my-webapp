resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket         = "${var.project_name}-artifacts-${random_id.suffix.hex}"
  force_destroy  = true
}

resource "aws_s3_bucket_lifecycle_configuration" "artifact_lifecycle" {
  bucket = aws_s3_bucket.artifact_bucket.id

  rule {
    id     = "DeleteOldArtifacts"
    status = "Enabled"

    # Delete objects older than 30 days
    expiration {
      days = 5
    }

    # Apply to all objects in the bucket
    filter {
      prefix = ""  # empty prefix = all objects
    }
  }
}
