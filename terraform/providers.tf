// ! Replace with  your AWS Profile
variable "aws_profile" {
	default = "terraform"
	type = string
}

// ! Replace with your prefered AWS region
variable "aws_region" {
	default = "us-east-1"
	type = string
}

provider "aws" {
	profile = var.aws_profile
	region = var.aws_region
	shared_credentials_file = "/root/.aws"
	version = "~> 2.57"
}
