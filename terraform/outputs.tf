output "ami_id" {
  value = "${data.aws_ami.this.id}"
}

output "appserver_ip" {
  value = "aws_instance.appserver.public_ip"
}

output "appserver_pip" {
  value = "aws_instance.appserver.private_ip"
}

output "dbmaster_ip" {
  value = "aws_instance.dbmaster.public_ip"
}

output "dbmaster_pip" {
  value = "aws_instance.dbmaster.private_ip"
}

output "dbslave_ip" {
  value = "aws_instance.dbslave.public_ip"
}

output "dbslave_pip" {
  value = "aws_instance.dbslave.private_ip"
}
