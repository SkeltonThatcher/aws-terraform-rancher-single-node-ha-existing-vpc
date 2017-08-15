# Rancher RDS security group

resource "aws_security_group" "rds" {
  name        = "${var.env_name}-rds-sg"
  vpc_id      = "${var.vpc_id}"
  description = "Rancher RDS security group"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.srv.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-rds-sg"
  }
}
