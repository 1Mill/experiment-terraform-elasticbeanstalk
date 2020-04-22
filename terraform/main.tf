
module "database" {
	source = "./modules/database"

	DATABASE_ENGINE = var.DATABASE_ENGINE
	DATABASE_ENGINE_VERSION = var.DATABASE_ENGINE_VERSION
	DATABASE_PASSWORD = var.DATABASE_PASSWORD
	DATABASE_PORT = var.DATABASE_PORT
	DATABASE_USERNAME = var.DATABASE_USERNAME
	PROJECT_NAME = var.PROJECT_NAME
}

resource "aws_s3_bucket" "app" {
	bucket = "${var.PROJECT_NAME}-app"

	force_destroy = true
}

resource "aws_elastic_beanstalk_application_version" "default" {
	application = aws_elastic_beanstalk_application.eb.name
	bucket = aws_s3_bucket.app.id
	key = "${var.APP_VERSION}.zip"
	name = var.APP_VERSION
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
	setting {
		name = "MaxSize"
		namespace = "aws:autoscaling:asg"
		value = "4"
	}
	setting {
		name = "MinSize"
		namespace = "aws:autoscaling:asg"
		value = "1"
	}
	setting {
		name = "RollingUpdateEnabled"
		namespace = "aws:autoscaling:updatepolicy:rollingupdate"
		value = "false"
	}
	setting {
		name = "SecurityGroups"
		namespace = "aws:autoscaling:launchconfiguration"
		value = module.database.aws_security_group.name
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
	setting {
		name = "DATABASE_HOST"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = module.database.host
	}
	setting {
		name = "DATABASE_PASSWORD"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = module.database.password
	}
	setting {
		name = "DATABASE_PORT"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = module.database.port
	}
	setting {
		name = "DATABASE_USERNAME"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = module.database.username
	}
	setting {
		name = "SECRET_KEY_BASE"
		namespace = "aws:elasticbeanstalk:application:environment"
		value = "MY_SUPER_SECURE_SECRET_KEY"
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
