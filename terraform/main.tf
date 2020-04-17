
variable "DIST_PATH" {
	default = "dist.zip"
	type = string
}
data "archive_file" "dist" {
	output_path = var.DIST_PATH

	source_dir = "./src"
	type = "zip"
}
resource "aws_s3_bucket" "app" {
	bucket = "${var.PROJECT_NAME}-app"
}
resource "aws_s3_bucket_object" "app" {
	bucket = aws_s3_bucket.app.id
	key="app.zip"
	source = var.DIST_PATH
}

resource "aws_elastic_beanstalk_application" "eb" {
	description = "${var.PROJECT_NAME} application (terraform-managed)"
	name = var.PROJECT_NAME
}
resource "aws_elastic_beanstalk_environment" "env" {
	application = aws_elastic_beanstalk_application.eb.name
	description = "${var.PROJECT_NAME} web site (terraform-managed)"
	version_label = aws_elastic_beanstalk_application_version.default.id

	name = "production"
	solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.4 running Ruby 2.6 (Puma)"
	tier= "WebServer"
}
resource "aws_elastic_beanstalk_application_version" "default" {
	application = aws_elastic_beanstalk_application.eb.name
	bucket = aws_s3_bucket.app.id
	key = aws_s3_bucket_object.app.id
	name = timestamp()

	description = "Application version (terraform-managed)"
}
