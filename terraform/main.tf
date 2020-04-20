resource "aws_s3_bucket" "app" {
	bucket = "${var.PROJECT_NAME}-app"
}

variable "DIST_PATH" {
	default = "dist.zip"
	type = string
}
data "archive_file" "dist" {
	output_path = var.DIST_PATH

	source_dir = "./src"
	type = "zip"
}
resource "aws_s3_bucket_object" "app" {
	bucket = aws_s3_bucket.app.id
	key="${timestamp()}.zip"
	source = var.DIST_PATH
}
resource "aws_elastic_beanstalk_application_version" "default" {
	application = aws_elastic_beanstalk_application.eb.name
	bucket = aws_s3_bucket.app.id
	key = aws_s3_bucket_object.app.id
	name = timestamp()

	description = "Application version (terraform-managed)"
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

	// Instance
	setting {
		name = "EC2KeyName"
		namespace = "aws:autoscaling:launchconfiguration"
		value = aws_key_pair.generated_key.key_name
	}
	setting {
		name = "InstanceTypes"
		namespace = "aws:ec2:instances"
		value = "t3.micro"
	}

	// Environmental varaibles
	setting {
		name = "RACK_ENV"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "production"
	}
	setting {
		name = "BUNDLE_WITHOUT"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "test:development"
	}
	setting {
		name = "RAILS_SKIP_ASSET_COMPILATION"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "false"
	}
	setting {
		name = "RAILS_SKIP_MIGRATIONS"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "false"
	}
}
resource "aws_key_pair" "generated_key" {
	key_name = "${var.PROJECT_NAME}-SSH-key"
	public_key = tls_private_key.generated_key.public_key_openssh
}
resource "tls_private_key" "generated_key" {
	algorithm = "RSA"
	rsa_bits  = 4096
}
