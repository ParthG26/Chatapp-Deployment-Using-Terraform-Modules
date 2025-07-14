resource "aws_db_subnet_group" "db_subnet_group" {
  name = "chat-db-subnet"
  subnet_ids = [
    var.private_subnets[0],
    var.private_subnets[1]
  ]
  tags = {
    Name = "ChatApp-DB-Subnet"
  }
}
resource "aws_db_instance" "DB" {
  identifier             = "chatapp"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.db_user
  password               = var.db_password
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible    = false
  skip_final_snapshot    = true
  tags = {
    Name = "ChatApp"
  }
}
