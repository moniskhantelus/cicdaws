resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-bucket-jenkin"
  force_destroy = false
}
