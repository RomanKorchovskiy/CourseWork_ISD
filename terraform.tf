provider "aws" {
	access_key = ""
	secret_key = ""
	region     = "us-east-1"
}

variable "instance_type_course_work_lw" {
	default = "t2.micro"
}

resource "aws_instance" "ec2_instance_course_work_lw" {
	ami = "ami-0885b1f6bd170450c"
	instance_type = var.instance_type_course_work_lw
	key_name = "lemp_wordpress"
	security_groups = [aws_security_group.ec2_security_group_course_work_lw.name]
}

resource "aws_security_group" "ec2_security_group_course_work_lw" {
    name = "ec2_security_group_course_work_lw"

    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]

        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "ip" {
	value = aws_instance.ec2_instance_course_work_lw.public_ip
}

resource "local_file" "ansibleHost" {
    content = templatefile("hosts",
        {
            public_ip = aws_instance.ec2_instance_course_work_lw.public_ip,
        }
    )
    filename = "hosts"
}
