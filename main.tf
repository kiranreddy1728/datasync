resource "aws_datasync_location_s3" "source" {
  s3_bucket_arn = "arn:aws:s3:::test17281728"
  subdirectory  = "/test/"

  s3_config {
    bucket_access_role_arn = aws_iam_role.datasync-s3-access-role.arn
  }

  tags = {
    Name = "datasync-agent-location-s3"
  }
}

resource "aws_datasync_location_fsx_windows_file_system" "destination" {
  fsx_filesystem_arn  = "arn:aws:fsx:us-east-1:662769160668:file-system/fs-082fe8d329d4daaf4"
  subdirectory  = "/share/"
  user                = "admin"
  password            = "Kiran123$"
  domain              = "kiran.datasync.com"
  security_group_arns = [aws_security_group.datasync-sg-mimx.arn]
}

resource "aws_cloudwatch_log_group" "datasync_log_group" {
  name = "/aws/datasync/mimx"
}

resource "aws_datasync_task" "datasync_mimx" {
  destination_location_arn = aws_datasync_location_fsx_windows_file_system.destination.arn
  name                     = "datasync-mimx-terraform"
  source_location_arn      = aws_datasync_location_s3.source.arn
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.datasync_log_group.arn

  options {
    bytes_per_second = -1
    posix_permissions = "NONE"
    uid = "NONE"
    gid = "NONE" 
    verify_mode = "ONLY_FILES_TRANSFERRED"
  }
}