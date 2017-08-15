# User-data template

data "template_file" "userdata_srv" {
  template = "${file("./files/userdata_srv.template")}"

  vars {
    # Database
    database_address  = "${aws_db_instance.rancher.address}"
    database_name     = "${var.db_name}"
    database_username = "${var.db_username}"
    database_password = "${var.db_password}"
  }
}

# Server launch configuration

resource "aws_launch_configuration" "rancher_srv" {
  image_id                    = "${lookup(var.ami_type, var.aws_region)}"
  instance_type               = "${var.srv_size}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.srv.id}"]
  iam_instance_profile        = "${aws_iam_instance_profile.rancher.id}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  user_data = "${data.template_file.userdata_srv.rendered}"
}

# Server auto scaling group

resource "aws_autoscaling_group" "rancher_srv" {
  name                      = "${var.env_name}-srv"
  availability_zones        = ["${var.pub_sub_a}", "${var.pub_sub_b}"]
  launch_configuration      = "${aws_launch_configuration.rancher_srv.name}"
  health_check_grace_period = 500
  health_check_type         = "EC2"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = ["${var.pub_sub_a}", "${var.pub_sub_b}"]
  load_balancers            = ["${aws_elb.rancher.name}"]

  tag {
    key                 = "Name"
    value               = "${var.env_name}-srv"
    propagate_at_launch = true
  }

  depends_on = ["aws_launch_configuration.rancher_srv"]

  provisioner "local-exec" {
    command = "./set_access_control.sh \"${var.rancher_admin_name}\" \"${var.rancher_admin_password}\" \"${var.rancher_admin_username}\" \"https://${var.env_name}.${data.aws_route53_zone.selected.name}\""
  }
}
