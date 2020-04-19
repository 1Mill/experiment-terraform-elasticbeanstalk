resource "aws_elastic_beanstalk_application" "eb" {
	description = "${var.PROJECT_NAME} application (terraform-managed)"
	name = var.PROJECT_NAME
}
resource "aws_elastic_beanstalk_environment" "env" {
	application = aws_elastic_beanstalk_application.eb.name
	description = "${var.PROJECT_NAME} web site (terraform-managed)"

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
		name = "SECRET_KEY_BASE"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "TODO: SOME RANDOM VALUE"
	}
	setting {
		name = "RACK_ENV"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "production"
	}
	setting {
		name = "BUNDLE_WITHOUT"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "test"
	}
}
resource "aws_key_pair" "generated_key" {
	key_name = "${var.PROJECT_NAME}-SSH-key"
	public_key = tls_private_key.example.public_key_openssh
}
resource "tls_private_key" "example" {
	algorithm = "RSA"
	rsa_bits  = 4096
}
