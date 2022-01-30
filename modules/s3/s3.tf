variable "owner" {}
variable "iam-role-id" {}
variable "bucket-name" {}
variable "project-name" {}
variable "environment" {}
variable "region" {}

resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket-name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name  = var.project_name
    Owner = var.owner
  }
}


resource "aws_iam_role_policy" "bucket-policy" {
  name   = "${var.project-name}-${var.environment}-bucket-policy"
  role   = var.iam-role-id
  policy = <<EOF
  {
    "Version" : "2021-10-17",
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
        "Resource" : ["arn:aws:s3:::${aws_s3_bucket.s3-bucket.id}"]
      },
      {
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : ["arn:aws:s3:::${aws_s3_bucket.s3-bucket.id}"]
      }
    ]
  }
EOF
}

output "s3_bucket_id" {
  value = "${aws_s3_bucket.s3-bucket.id}"
}
