# S3 Bucket for Kinesis Firehose 
resource "aws_s3_bucket" "kinesis_firehose_s3_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

# IAM Role for Kinesis Firehose
resource "aws_iam_role" "kinesis_firehose_role" {
  name        = var.kinesis_firehose_role_name
  description = "IAM Role for Kinesis Firehose"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

# Kinesis Firehose Stream for Datadog
resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_stream" {
  name        = var.firehose_name
  destination = "http_endpoint"

  s3_configuration {
    role_arn           = aws_iam_role.kinesis_firehose_role.arn
    bucket_arn         = aws_s3_bucket.kinesis_firehose_s3_bucket.arn
  }

  http_endpoint_configuration {
    url                = var.endpoint_url
    name               = "Datadog"
    access_key         = data.aws_kms_secrets.datadog_endpoint_key.plaintext["endpoint_key"]
    buffering_size     = var.kinesis_firehose_buffer
    buffering_interval = var.kinesis_firehose_buffer_interval
    role_arn           = aws_iam_role.kinesis_firehose_role.arn
    s3_backup_mode     = var.s3_backup_mode

    request_configuration {
      content_encoding = var.content_encoding
    }
  }
}

# Sensitivity for Datadog Key
data "aws_kms_secrets" "datadog_endpoint_key" {
  secret {
    name    = "endpoint_key"
    payload = var.endpoint_key
  }
}