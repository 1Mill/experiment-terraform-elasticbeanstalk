output "url" {
	value = aws_elastic_beanstalk_environment.default.endpoint_url
}

// ? Need to access the EC2 instance? Uncomment this
// ? and copy the private key to a .pem file.
// output "private_key" {
// 	value = tls_private_key.default.private_key_pem
// }
