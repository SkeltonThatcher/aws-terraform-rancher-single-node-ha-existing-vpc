# Rancher srv security group

resource "aws_security_group" "srv" {
  name        = "${var.env_name}-srv-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Rancher server security group"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "tcp"
    security_groups = ["${aws_security_group.hst.id}"]
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
    Name = "${var.env_name}-srv-sg"
  }
}
