output "host" {
	value = aws_db_instance.default.address
}
output "password" {
	value = var.DATABASE_PASSWORD
}
output "port" {
	value = aws_db_instance.default.port
}
output "aws_security_group" {
	value = aws_security_group.default
}
output "username" {
	value = aws_db_instance.default.username
}
