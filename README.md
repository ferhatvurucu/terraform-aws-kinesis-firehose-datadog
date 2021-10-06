# terraform-aws-kinesis-firehose-datadog

A terraform module to configure Amazon Kinesis Firehose and send the log data to Datadog using HTTP Endpoint.

# Usage

Datadog Endpoint and API Key must be defined in module resource properly. Make sure you use a AWS KMS Key to encrypt the API Key as it is sensitive resource. Please see example usage [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_secrets#example-usage).

```hcl
module "kinesis-firehose-datadog" {
  source          = "ferhatvurucu/kinesis-firehose-datadog/aws"
  region          = "eu-west-1"
  endpoint_url    = "<Datadog_HTTP_endpoint_URL>"
  endpoint_key    = "<KMS_encrypted_API_key>"
  kms_key_arn     = "arn:aws:kms:us-west-1:<aws_account_number:key/<kms_key_id>"
  s3_bucket_name  = "<unique_bucket_name>"
}
```

# Requirements

Name      | Version
-----     | --------
terraform | >= 0.13.0
aws       | >= 3.3.0

# Providers

Name  | Version
----- | --------
aws   | >= 3.3.0

# Inputs

Name      | Description | Type | Default | Required
-----     | --------    | ---- | ----    | --------
region    | AWS region such as eu-west-1 or us-east-1  |  string    |   -      | yes
endpoint_url    | Datadog HTTP Endpoint URL for streaming logs to Datadog  |  string    |   -      | yes
endpoint_key    | Encrypted Datadog API Key to submit data to Datadog  |  string    |   -      | yes
kms_key_arn    | ARN of the KMS key used to encrypt the Datadog API Key  |  string    |   -      | yes
firehose_name    | Name of the Kinesis Firehose  |  string    |   ```kinesis-firehose-to-datadog```     | no
kinesis_firehose_buffer    | Buffer incoming data to the specified size in MBs  |  integer    |   ```5```     | no
kinesis_firehose_buffer_interval    | Buffer incoming data for the specified period of time in seconds  |  integer    |   ```300```     | no
tags   | Map of tags to put on the resource  |  map    |   ```{}```     | no
s3_bucket_name   | Name of the s3 bucket Kinesis Firehose uses for backups  |  string    |   -     | yes
kinesis_firehose_role_name   | Name of IAM Role for the Kinesis Firehose  |  string    |   ```KinesisFirehoseDatadogRole```     | no
content_encoding   | Valid values are NONE and GZIP  |  string    |   ```NONE```     | no
s3_backup_mode   | Valid values are FailedDataOnly and AllData  |  string    |   ```FailedDataOnly```     | no

# Outputs

Name      | Description 
-----     | --------    
kinesis_firehose_stream_arn    | ARN associated with the Kinesis Firehose Stream

# References

For additional context, refer to some of these links.

- [Analyze logs with Datadog using Amazon Kinesis Data Firehose HTTP endpoint delivery](https://aws.amazon.com/blogs/big-data/analyze-logs-with-datadog-using-amazon-kinesis-data-firehose-http-endpoint-delivery/)
- [Choose Datadog for Your Destination](https://docs.aws.amazon.com/firehose/latest/dev/create-destination.html#create-destination-datadog)
