# Create Rds sub-net grp
resource "aws_db_subnet_group" "mydb" {
  name       = "main"
  subnet_ids = [aws_subnet.datasbPR1.id, aws_subnet.datasbPR2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# Create Rds Security Grp

resource "aws_security_group" "DataBaseSeucrityGrp1" {
  name        = "allow HTTP/HTTPS"
  description = "Allow HTTP/HTTPS access on port 80/443"
  vpc_id      = aws_vpc.dataserver.id

  ingress {
    description      = "HTTPS from Internetgateway"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "HTTP Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }






  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


#create db mysql instance


resource "aws_db_instance" "MySQL" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name    = aws_db_subnet_group.mydb.name
  vpc_security_group_ids  = [aws_security_group.DataBaseSeucrityGrp1.id]

}

