resource "aws_launch_template" "webserver_launch_template" {
  name          = "webserver-launch-template"
  image_id      = "ami-697658"  
  instance_type = "t2.micro"     
  key_name      = "my-keypair"    
  description   = "Launch template for webserver instances"

  monitoring {
    enabled = true
  }

  vpc_security_group_ids = ["sg-xxxxxxxx"]  
}

