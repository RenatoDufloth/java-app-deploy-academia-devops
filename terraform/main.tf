provider "aws" {
  region = "us-east-1"
}


data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}


resource "aws_instance" "maquina_nodejs" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = "key-dufloth-devout"
  tags = {
    Name = "dufloth-maquina_ansible_com_nginx_e_nodejs"
  }
  subnet_id                   = "subnet-05cdfe4fe6a3d1c13"
  associate_public_ip_address = true

  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.acessos_nodejs.id]
}

resource "aws_security_group" "acessos_nodejs" {
  name        = "acessos_nodejs-dufloth"
  description = "acessos inbound traffic"
  vpc_id      = "vpc-0404e2502328d5e45"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh_dufloth"
  }
}

output "aws_instance_e_ssh" {
  value = aws_instance.maquina_nodejs.public_dns
}
