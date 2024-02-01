resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-jagat"

  tags = {
    Name        = "my-tf-test-bucket-jagat"
    Environment = "Dev"
  }
}
