variable "DATABASE_PASSWORD" {
	type = string
}
variable "DATABASE_USERNAME" {
	type = string
}
variable "PROJECT_NAME"{
	type = string
}
resource "aws_db_instance" "database" {
	auto_minor_version_upgrade = true
	engine = "postgres"
	engine_version = "11.6"
	instance_class = "db.t3.micro"
	name = "${var.PROJECT_NAME}-database"
	password = var.DATABASE_PASSWORD
	username = var.DATABASE_USERNAME
}
