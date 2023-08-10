#KEYS

variable "aws_access_key" {
  type        = string
}

variable "aws_secret_key" {
  type        = string
}

#REGION

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

#VPC

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

#SUBNET

variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

#AVAILABILITY ZONE

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1a"
}

#ROUTE TABLE

variable "route_table_cidr_block" {
  description = "Route Table CIDR block"
  type        = string
  default     = "0.0.0.0/0"
}

#INSTANCE TYPE

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

#AMI ID

variable "aws_ami" {
  description = "Instance AMI ID"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "ssh_user" {
  description = "Default user on instance"
  type        = string
  default     = "ubuntu"
}

variable "ssh_private_key_file" {
  type        = string
}

variable "key_pair_name" {
  description = "AWS EC2 key-pair name"
  type        = string
  default     = "shtajiryan"
}

variable "s3_bucket_name" {
  description = "S3 bucket for Terraform state"
  type        = string
  default     = "shtajiryan-terraform-state-bucket"
}