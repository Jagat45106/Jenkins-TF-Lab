resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-jagat"

  tags = {
    Name        = "my-tf-test-bucket-jagat"
    Environment = "Dev"
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
