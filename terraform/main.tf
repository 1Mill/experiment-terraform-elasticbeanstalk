variable "DATABASE_ENGINE" {
	type = string
}
variable "DATABASE_ENGINE_VERSION" {
	type = string
}
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
	engine = var.DATABASE_ENGINE
	engine_version = var.DATABASE_ENGINE_VERSION
	identifier = "${var.PROJECT_NAME}-database"
	password = var.DATABASE_PASSWORD
	username = var.DATABASE_USERNAME

	allocated_storage = 100
	auto_minor_version_upgrade = true
	instance_class = "db.t3.micro"
	max_allocated_storage = 1000
	name = "production"
	skip_final_snapshot = true
}
