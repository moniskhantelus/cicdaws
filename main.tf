resource "aws_s3_bucket" "demo_bucket" {
  bucket = "monis-demo-bucket-12345"
  force_destroy = true
}
