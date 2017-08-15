# RDS subnet group

resource "aws_db_subnet_group" "rancher" {
  name        = "${var.env_name}-rds-sn"
  subnet_ids  = ["${var.priv_sub_a}", "${var.priv_sub_b}"]
  description = "${var.env_name}-rds-sn"

  tags {
    Name = "${var.env_name}-rds-sn"
  }
}

# RDS instance

resource "aws_db_instance" "rancher" {
  engine                    = "mysql"
  storage_type              = "gp2"
  instance_class            = "${var.db_class}"
  name                      = "${var.db_name}"
  username                  = "${var.db_username}"
  password                  = "${var.db_password}"
  allocated_storage         = "${var.db_storage}"
  backup_retention_period   = "${var.db_backup_retention}"
  multi_az                  = "${var.db_multi_az}"
  identifier                = "${var.env_name}-rds"
  db_subnet_group_name      = "${aws_db_subnet_group.rancher.name}"
  vpc_security_group_ids    = ["${aws_security_group.rds.id}"]
  final_snapshot_identifier = "${var.env_name}-snapshot"
  skip_final_snapshot       = "${var.db_final_snapshot}"

  #parameter_group_name      = "rancher-pg"
}

#resource "aws_db_parameter_group" "rancher" {
#  name   = "rancher-pg"
#  family = "mysql5.6"


#  parameter {
#    name  = "character_set_client"
#    value = "utf8"
#  }


#  parameter {
#    name  = "character_set_connection"
#    value = "utf8"
#  }


#  parameter {
#    name  = "character_set_database"
#    value = "utf8"
#  }


#  parameter {
#    name  = "character_set_filesystem"
#    value = "utf8"
#  }


#  parameter {
#    name  = "character_set_results"
#    value = "utf8"
#  }


#  parameter {
#    name  = "character_set_server"
#    value = "utf8"
#  }


#  parameter {
#    name  = "collation_connection"
#    value = "utf8_general_ci"
#  }


#  parameter {
#    name  = "collation_server"
#    value = "utf8_general_ci"
#  }
#}

