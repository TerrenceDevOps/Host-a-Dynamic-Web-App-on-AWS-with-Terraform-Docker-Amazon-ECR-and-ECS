# Application Load Balancer
resource "aws_lb" "application_load_balancer" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_az1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.public_subnet_az2.id
  }

  enable_deletion_protection = false

  tags = {
    Name = "app-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "app-tg"
  target_type = "instance" # Use "ip" if using ECS/Fargate
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "app-tg"
  }
}

# HTTP Listener - Redirect to HTTPS
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener - Forward to target group
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
