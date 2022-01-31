output "arn" {
  value = aws_lambda_function.tf_lambda_function.arn
}

output "last_modified" {
  value = aws_lambda_function.tf_lambda_function.last_modified
}

output "role_id" {
  value = aws_iam_role.tf_lambda_uploader_role.id
}
