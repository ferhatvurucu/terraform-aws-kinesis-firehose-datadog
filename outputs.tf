output "kinesis_firehose_stream_arn" {
  description = "ARN associated with the Kinesis Firehose Stream"
  value       = aws_kinesis_firehose_delivery_stream.kinesis_firehose_stream.arn
}