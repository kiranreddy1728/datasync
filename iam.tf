

data "aws_iam_policy_document" "datasync_assume_role" {
  statement {
    actions = ["sts:AssumeRole",]
    principals {
      identifiers = ["datasync.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "bucket_access" {
  statement {
      sid = "1"
      actions = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads"
      ]
      effect = "Allow"
      resources = [
          "arn:aws:s3:::test17281728"
      ]
  }
  statement {
      sid = "2"
      actions = [
          "s3:AbortMultipartUpload",
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:ListMultipartUploadParts",
          "s3:PutObjectTagging",
          "s3:GetObjectTagging",
          "s3:PutObject"
      ]
      effect = "Allow"
      resources = [
          "arn:aws:s3:::test17281728/*"
      ]
  }
}

resource "aws_iam_role" "datasync-s3-access-role" {
  name               = "datasync-s3-access-role-mimx"
  assume_role_policy = data.aws_iam_policy_document.datasync_assume_role.json
}

resource "aws_iam_role_policy" "datasync-s3-access-policy" {
  name   = "datasync-s3-access-policy-mimx"
  role   = aws_iam_role.datasync-s3-access-role.name
  policy = data.aws_iam_policy_document.bucket_access.json
}