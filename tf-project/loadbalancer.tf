
resource "aws_lb" "app-lb" {
  name                       = "app-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  enable_deletion_protection = false
  tags = {
    name = "application-lb"
  }
}

resource "aws_lb_target_group" "lb-tg" {
  name     = "loadbalancer-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app.id
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg-attachment-1" {
  target_group_arn = aws_lb_target_group.lb-tg.arn
  target_id        = aws_instance.nginx-webapp-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg-attachment-2" {
  target_group_arn = aws_lb_target_group.lb-tg.arn
  target_id        = aws_instance.nginx-webapp-2.id
  port             = 80
}