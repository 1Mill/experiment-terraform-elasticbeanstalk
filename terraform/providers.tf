variable "AWS_PROFILE" {
	type = string
}
variable "AWS_REGION" {
	type = string
}
provider "aws" {
	profile = var.AWS_PROFILE
	region = var.AWS_REGION

	shared_credentials_file = "/root/.aws"
	version = "~> 2.58"
}

provider "tls" {
	version = "~> 2.1"
}
