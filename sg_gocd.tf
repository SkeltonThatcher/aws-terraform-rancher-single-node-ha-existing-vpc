# GoCD security group

resource "aws_security_group" "gocd" {
  name        = "${var.env_name}-gocd-sg"
  vpc_id      = "${var.vpc_id}"
  description = "GoCD security group"

  ingress {
    from_port   = 8153
    to_port     = 8154
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-gocd-sg"
  }
}
