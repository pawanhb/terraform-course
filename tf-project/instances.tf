#### Datasource for getting latest AMI ID

data "aws_ssm_parameter" "amzn2-lnx" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}



##EC2 Instance

resource "aws_instance" "nginx-webapp-1" {
  ami                    = data.aws_ssm_parameter.amzn2-lnx.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<EOF
  #! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Terraform Nginx Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Hello From Server 1!!!</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}

resource "aws_instance" "nginx-webapp-2" {
  ami                    = data.aws_ssm_parameter.amzn2-lnx.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  user_data = <<EOF
  #! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Terraform Nginx Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Hello From Server 2!!!</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}