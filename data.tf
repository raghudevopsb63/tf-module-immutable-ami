data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "base-with-ansible"
  owners      = ["self"]
}

data "aws_secretsmanager_secret" "secrets" {
  name = "dev/roboshop/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

