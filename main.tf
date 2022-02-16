provider "aws"{
access_key = "AKIAWNPAON5TC2DFTU4A"
secret_key = "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"
region = "us-east-1"
}

#Creating aws ec2 instance


resource "aws_instance" "Terraform_EC2_Instance"{
        ami = "ami-0e472ba40eb589f49"
        instance_type = "t2.micro"
        availability_zone = "us-east-1a"
        vpc_security_group_ids = ["${aws_security_group.hello-terra-ssh-http.id}"]
        key_name = "ovalhr"
        user_data = "${file("install_docker.sh")}"
        tags = {
                        Name = "Web-Server"
        }
}

#Publishing IP of the apache server
output "server_ip" {
  value = aws_instance.Terraform_EC2_Instance.public_ip
}
resource "aws_security_group" "hello-terra-ssh-http"{
        name = "hello-terra-ssh-http"

        ingress {
                        from_port = 22
                        to_port = 22
                        protocol = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                        from_port = 80
                        to_port = 80
                        protocol = "tcp"
                        cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
                        from_port = 0
                        to_port = 0
                        protocol = "-1"
                        cidr_blocks = ["0.0.0.0/0"]
        }
}
