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