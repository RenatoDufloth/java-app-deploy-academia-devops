
resource "aws_security_group" "allow_ssh" {
	  name        = "allow_ssh_docker-dufloth"
	  description = "Allow ssh inbound traffic"
	  vpc_id      = "vpc-0404e2502328d5e45"
	

	

	  ingress = [
	    {
	      description      = "ssh from VPC"
	      from_port        = 22
	      to_port          = 22
	      protocol         = "tcp"
	      cidr_blocks      = ["0.0.0.0/0"]
	      ipv6_cidr_blocks = ["::/0"]
	      prefix_list_ids  = null
	      security_groups : null
	      self : null
	     },
	     {
	      description      = "Acesso HTTPS"
	      from_port        = 443
	      to_port          = 443
	      protocol         = "tcp"
	      cidr_blocks      = ["0.0.0.0/0"]
	      ipv6_cidr_blocks = ["::/0"]
	      prefix_list_ids = null,
	      security_groups: null,
	      self: null
	    }
	    
	

	  ]
	

	  egress = [
	    {
	      description      = "ssh from VPC"
	      from_port        = 0
	      to_port          = 0
	      protocol         = "-1"
	      cidr_blocks      = ["0.0.0.0/0"]
	      ipv6_cidr_blocks = ["::/0"]
	      prefix_list_ids  = null
	      security_groups : null
	      self : null
	    }
	  ]
	

	

	  tags = {
	    Name = "allow_ssh_docker-dufloth"
	  }
	}
	resource "aws_security_group" "allow_80" {
	  name        = "allow_80_docker-dufloth"
	  description = "Allow 80 inbound traffic"
	  vpc_id      = "vpc-0404e2502328d5e45"
	

	

	  ingress = [
	    {
	      description      = "80 from VPC"
	      from_port        = 80
	      to_port          = 80
	      protocol         = "tcp"
	      cidr_blocks      = ["0.0.0.0/0"]
	      ipv6_cidr_blocks = ["::/0"]
	      prefix_list_ids  = null
	      security_groups : null
	      self : null
	    }
	

	  ]
	

	  egress = [
	    {
	      description      = "80 from VPC"
	      from_port        = 0
	      to_port          = 0
	      protocol         = "-1"
	      cidr_blocks      = ["0.0.0.0/0"]
	      ipv6_cidr_blocks = ["::/0"]
	      prefix_list_ids  = null
	      security_groups : null
	      self : null
	    }
	  ]
	

	

	  tags = {
	    Name = "allow_docker-dufloth"
	  }
	}



