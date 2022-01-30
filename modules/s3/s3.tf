variable "owner" {}

variable "iam_role_id" {}

variable "bucket_name" {}

variable "project_name" {}

variable "environment" {}

variable "region" {}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name  = var.project_name
    Owner = var.owner
  }
}


resource "aws_iam_role_policy" "bucket_policy" {
  name   = "${var.project_name}_${var.environment}_bucket_policy"
  role   = var.iam_role_id
  policy = <<EOF
  {
    "Version" : "2021_10_17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Effect" : "Allow",
        "Action" : ["s3:ListBucket"],
        "Resource" : ["arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}"]
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : ["arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}"]
      }
    ]
  }
EOF
}

output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}
