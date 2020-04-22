resource "aws_db_instance" "default" {
	engine = var.DATABASE_ENGINE
	engine_version = var.DATABASE_ENGINE_VERSION
	identifier = "${var.PROJECT_NAME}-database"
	password = var.DATABASE_PASSWORD
	username = var.DATABASE_USERNAME
	vpc_security_group_ids = [aws_security_group.default.id]

	allocated_storage = 100
	auto_minor_version_upgrade = true
	instance_class = "db.t3.micro"
	max_allocated_storage = 1000
	name = "production"
	skip_final_snapshot = true
}
resource "aws_security_group" "default" {
	description = "Database ${var.DATABASE_ENGINE} security group (terraform-managed)"
	name = "${var.PROJECT_NAME}-database-sg"

	ingress {
		from_port = var.DATABASE_PORT
		to_port = var.DATABASE_PORT

		cidr_blocks = ["0.0.0.0/0"]
		protocol = "tcp"
	}

	egress {
		cidr_blocks = ["0.0.0.0/0"]
		protocol = "-1"
		from_port = 0
		to_port = 0
	}
}
