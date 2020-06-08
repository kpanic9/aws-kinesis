provider "aws" {
  region     = "ap-southeast-2"
  access_key = "xxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxx"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true
  skip_requesting_account_id  = true

  endpoints {
    kinesis  = "http://localhost:4568"
    s3       = "http://localhost:4572"
    firehose = "http://localhost:4573"
    lambda   = "http://localhost:4574"
    iam      = "http://localhost:4593"
  }

}


resource "aws_kinesis_stream" "app_stream" {
  name             = "kinesis_app_stream"
  shard_count      = 1
  retention_period = 48

  #    shard_level_metrics = [
  #        "IncomingBytes",
  #        "OutgoingBytes",
  #    ]

  tags = {
    Environment = "Dev"
  }
}

# aws s3 bucket for storing kinesis stream events
resource "aws_s3_bucket" "kinesis_event_bucket" {
  # random string at the end is because s3 is a global resource
  bucket = "kinesis-stream-events-bucket-awqwdefevf"
  acl    = "private"

  tags = {
    Name        = "Kinesis Stream Event Bucket"
    Environment = "Dev"
  }
}

# role for firehose to assume when accessing s3 and kinesis
resource "aws_iam_role" "firehose_role" {
  name = "firehose_role"

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
}

# role policy granting firehose access to s3 and kenisis
resource "aws_iam_role_policy" "firehose_policy" {
  name = "firehose_policy"
  role = "${aws_iam_role.firehose_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:*",
                "kinesis:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "event_delivery_stream" {
  name        = "firehose-stream-to-s3"
  destination = "s3"

  kinesis_source_configuration {
    kinesis_stream_arn = "${aws_kinesis_stream.app_stream.arn}"
    role_arn           = "${aws_iam_role.firehose_role.arn}"
  }

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.kinesis_event_bucket.arn}"
  }
}
