# General

variable "environment" {
}

variable "owner" {
}

variable "repository" {
}

# AWS

variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
}

variable "external_uploader_region" {
  default = "us-east-1"
}

variable "principal" {
  description = "AWS account ID"
}

variable "external_uploader_user" {
  description = "Name of external uploader"
}

variable "external_uploader_account" {
  description = "AWS account ID of external uploader"
}

# Lambda specific

variable "lambda_handler" {
  description = "Code entrypoint"
}

variable "lambda_function_name" {
}

# Lambda - Optional #

variable "lambda_s3_bucket" {
}

variable "lambda_timeout" {
}

variable "lambda_runtime" {
}

variable "lambda_memory_size" {
}

variable "lambda_description" {
}

variable "lambda_vpc_subnet_ids" {
}

variable "lambda_vpc_security_group_ids" {
}

variable "lambda_assume_role_policy" {
  default = <<EOF
{
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            }
        }
    ]
}
EOF

}

variable "lambda_policy" {
}

variable "lambda_environment_variables" {
  type        = map(string)
}
