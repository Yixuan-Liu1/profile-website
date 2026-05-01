resource "aws_iam_user" "cicd" {
  name = "resume-cicd"
}

resource "aws_iam_access_key" "cicd" {
  user = aws_iam_user.cicd.name
}

resource "aws_iam_user_policy" "cicd" {
  name = "resume-cicd-policy"
  user = aws_iam_user.cicd.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["cloudfront:CreateInvalidation"]
        Resource = "*"
      }
    ]
  })
}

output "cicd_access_key_id" {
  value     = aws_iam_access_key.cicd.id
  sensitive = true
}

output "cicd_secret_access_key" {
  value     = aws_iam_access_key.cicd.secret
  sensitive = true
}
