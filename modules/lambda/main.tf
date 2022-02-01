provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
  profile    = var.aws_profile
}

resource "aws_iam_role" "lambda_uploader_role" {
  name = "iam_lambda_uploader_${var.lambda_function_name}"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy_${var.lambda_function_name}"
  role = "${aws_iam_role.lambda_uploader_role.id}"
  policy = "${file(${path.module}/policy.json)}"
}

