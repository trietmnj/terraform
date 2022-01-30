variable "project_name" {}

variable "environment" {}

variable "bucket_id" {}

resource "aws_iam_role" "role" {
  name               = "${var.project_name}_${var.environment}_lambda_role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "policy" {
  name   = "${var.project_name}_${var.environment}_lambda_general_policy"
  role   = aws_iam_role.role.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource": "arn:aws:s3:::"
      }
    ]
  }
  EOF
}

