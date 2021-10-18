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
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_80.id}"]
  #vpc_security_group_ids = [aws_security_group.acessos_nodejs.id]
}



output "aws_instance_e_ssh" {
  value = aws_instance.maquina_nodejs.public_dns
}
