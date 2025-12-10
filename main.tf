resource "aws_s3_bucket" "demo_bucket" {
  bucket = "monis-demo-bucket"
  force_destroy = true
}
