# Rancher host security group

resource "aws_security_group" "hst" {
  name        = "${var.env_name}-hst-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Rancher host security group"

  ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"
    cidr_blocks = ["${var.pub_sub_a_cidr}"]
  }

  ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"
    cidr_blocks = ["${var.pub_sub_a_cidr}"]
  }

  ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"
    cidr_blocks = ["${var.pub_sub_b_cidr}"]
  }

  ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"
    cidr_blocks = ["${var.pub_sub_b_cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "${var.env_name}-hst-sg"
  }
}
