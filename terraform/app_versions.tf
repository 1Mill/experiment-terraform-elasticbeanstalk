resource "aws_s3_bucket" "app" {
	bucket = "${var.PROJECT_NAME}-app"
}
