resource "aws_s3_bucket" "demo_bucket" {
  bucket = "monis-demo-bucket-jenkins"
  force_destroy = true
}
