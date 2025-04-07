# Create a DB subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "mysql-db-subnet-group"
  subnet_ids  = [
    aws_subnet.private_data_subnet_az1.id,
    aws_subnet.private_data_subnet_az2.id
  ]
  description = "Subnet group for MySQL DB instance"

  tags = {
    Name = "mysql-db-subnet-group"
  }
}

# Provision a fresh MySQL DB instance
resource "aws_db_instance" "mysql_db_instance" {
  identifier              = "mysql-db-instance"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  allocated_storage       = var.allocated_storage
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  port                    = 3306
  multi_az                = true
  publicly_accessible     = false
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]

  tags = {
    Name = "mysql-db-instance"
  }
}
