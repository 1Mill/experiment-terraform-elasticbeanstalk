// ! Replace with  your AWS Profile
variable "aws_profile" {
	type = string
}

// ! Replace with your prefered AWS region
variable "aws_region" {
	type = string
}

provider "aws" {
	profile = var.aws_profile
	region = var.aws_region
	shared_credentials_file = "/root/.aws"
	version = "~> 2.57"
}
