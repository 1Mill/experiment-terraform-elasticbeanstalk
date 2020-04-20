variable "DATABASE_ENGINE" {
	type = string
}
variable "DATABASE_ENGINE_VERSION" {
	type = string
}
variable "DATABASE_PASSWORD" {
	type = string
}
variable "DATABASE_PORT" {
	type = string
}
variable "DATABASE_USERNAME" {
	type = string
}
resource "aws_db_instance" "database" {
	engine = var.DATABASE_ENGINE
	engine_version = var.DATABASE_ENGINE_VERSION
	identifier = "${var.PROJECT_NAME}-database"
	password = var.DATABASE_PASSWORD
	username = var.DATABASE_USERNAME
	vpc_security_group_ids = [aws_security_group.database.id]

	allocated_storage = 100
	auto_minor_version_upgrade = true
	instance_class = "db.t3.micro"
	max_allocated_storage = 1000
	name = "production"
	skip_final_snapshot = true
}
resource "aws_security_group" "database" {
	description = "RDS ${var.DATABASE_ENGINE} sg (terraform-managed)"
	name = "${var.PROJECT_NAME}-database-sg"

	ingress {
		from_port = var.DATABASE_PORT
		to_port = var.DATABASE_PORT

		cidr_blocks = ["0.0.0.0/0"]
		protocol = "tcp"
	}

	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		protocol = "-1"
		to_port = 0
	}
}
