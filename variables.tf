variable "region" {
  description = "AWS region such as eu-west-1 or us-east-1"
}

variable "endpoint_url" {
  description = "Datadog HTTP Endpoint URL for streaming logs to Datadog"
}

variable "endpoint_key" {
  description = "Datadog API Key to submit data to Datadog"
}

variable "firehose_name" {
  description = "Name of the Kinesis Firehose"
  default     = "kinesis-firehose-to-datadog"
}

variable "kinesis_firehose_buffer" {
  description = "Buffer incoming data to the specified size in MBs"
  default     = 5
}

variable "kinesis_firehose_buffer_interval" {
  description = "Buffer incoming data for the specified period of time in seconds"
  default     = 300
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to put on the resource"
  default     = {}
}

variable "s3_bucket_name" {
  description = "Name of the s3 bucket Kinesis Firehose uses for backups"
}

variable "kinesis_firehose_role_name" {
  description = "Name of IAM Role for the Kinesis Firehose"
  default     = "KinesisFirehoseDatadogRole"
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the Datadog API Key"
}

variable "content_encoding" {
  description = "Valid values are NONE and GZIP"
  default = "NONE"
}

variable "s3_backup_mode" {
  description = "Valid values are FailedDataOnly and AllData"
  default = "FailedDataOnly"
}