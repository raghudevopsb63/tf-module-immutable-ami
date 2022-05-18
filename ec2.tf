resource "aws_instance" "ami-instance" {
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  ami                    = data.aws_ami.ami.id
  iam_instance_profile   = "dev_instance_profile"
}

resource "null_resource" "app-setup" {
  provisioner "remote-exec" {
    connection {
      host     = aws_instance.ami-instance.public_ip
      user     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USERNAME"]
      password = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
    }
    inline = [
      "ansible-pull -U https://github.com/raghudevopsb63/ansible roboshop.yml  -e role_name=${var.COMPONENT} -e HOST=localhost -e APP_VERSION=${var.APP_VERSION} -e ENV=ENV -e MONGODB_ENDPOINT=MONGODB_ENDPOINT"
    ]
  }
}
