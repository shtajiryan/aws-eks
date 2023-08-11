# VPC

resource "aws_vpc" "mongodb-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "MongoDB VPC"
        Database = "Yes"
    }
}

# Internet Gateway

resource "aws_internet_gateway" "mongodb-ig" {
    vpc_id = aws_vpc.mongodb-vpc.id
    tags = {
        Name = "MongoDB Internet Gateway"
        Database = "Yes"
    }
}

# Route Table

resource "aws_route_table" "mongodb-route-table-us-east-1a-public" {
    vpc_id = aws_vpc.mongodb-vpc.id
    route {
        cidr_block = var.route_table_cidr_block
        gateway_id = aws_internet_gateway.mongodb-ig.id
    }
    tags = {
        Name = "MongoDB Route Table"
        Database = "Yes"
    }
}

resource "aws_route_table_association" "mongodb-route-table-association" {
    subnet_id = aws_subnet.mongodb-subnet.id
    route_table_id = aws_route_table.mongodb-route-table-us-east-1a-public.id
}


# Subnet

resource "aws_subnet" "mongodb-subnet" {
    vpc_id = aws_vpc.mongodb-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
        Name = "MongoDB Subnet"
        Database = "Yes"
    }
}

# Security Group

resource "aws_security_group" "mongodb-sg" {
    name = "Allow SSH, 27017"
    description = "Allow SSH and MongoDB"
    vpc_id = aws_vpc.mongodb-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "MongoDB Security Group"
        Database = "Yes"
    }
}


resource "aws_instance" "mongodb-instance" {
    ami = "${var.aws_ami}"
    key_name = var.key_pair_name
    instance_type = var.instance_type
    subnet_id = aws_subnet.mongodb-subnet.id
    vpc_security_group_ids = [aws_security_group.mongodb-sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "MongoDB Instance"
        Database = "Yes"
    }

    provisioner "remote-exec" {
        inline = ["echo 'Wait until SSH is ready'"]

        connection {
            type = "ssh"
            user = var.ssh_user
            private_key = file(var.ssh_private_key_file)
            host = self.public_ip
        }
    }

    provisioner "local-exec" {
        command = "ssh-keyscan ${aws_instance.mongodb-instance.public_ip} >> ~/.ssh/known_hosts"
    }
    
    provisioner "local-exec" {
        command = "ansible-playbook --private-key ${var.ssh_private_key_file} -i '${self.public_ip},' ../ansible/playbook.yml"
  }
}