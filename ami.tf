resource "aws_ami_from_instance" "ami" {
  depends_on         = [null_resource.app-setup]
  name               = "${var.COMPONENT}-${var.APP_VERSION}"
  source_instance_id = aws_instance.ami-instance.id
  tags = {
    Name        = "${var.COMPONENT}-${var.APP_VERSION}"
    COMPONENT   = var.COMPONENT
    APP_VERSION = var.APP_VERSION
  }
}

