# VPC Variables
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnet_az1_cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet AZ1 CIDR"
  type        = string
}

variable "public_subnet_az2_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet AZ2 CIDR"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  default     = "10.0.2.0/24"
  description = "Private App Subnet AZ1 CIDR"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  default     = "10.0.3.0/24"
  description = "Private App Subnet AZ2 CIDR"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  default     = "10.0.4.0/24"
  description = "Private Data Subnet AZ1 CIDR"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  default     = "10.0.5.0/24"
  description = "Private Data Subnet AZ2 CIDR"
  type        = string
}

variable "az1" {
  default     = "us-east-1a"
  description = "Availability Zone 1"
}

variable "az2" {
  default     = "us-east-1b"
  description = "Availability Zone 2"
}

# IP or CIDR block allowed for SSH access
variable "ssh_allowed_cidr" {
  description = "The IP address range allowed to access SSH (port 22) on bastion hosts"
  type        = string
  default     = "0.0.0.0/0" # Change this to your IP like "203.0.113.10/32"
}

# SSH port variable (optional, default is 22)
variable "ssh_port" {
  description = "Port to allow SSH access on"
  type        = number
  default     = 22
}

variable "db_instance_class" {
  description = "Instance class for the MySQL DB"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Storage in GB for the MySQL DB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "myappdb"
}

variable "db_username" {
  description = "Master username for MySQL"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for MySQL"
  type        = string
  sensitive   = true
}
variable "acm_certificate_arn" {
  description = "ACM Certificate ARN for HTTPS"
  type        = string
}
variable "public_subnet_az1" {
  description = "Public Subnet AZ1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_app_subnet_az1" {
  description = "Private App Subnet AZ1"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_data_subnet_az1" {
  description = "Private Data Subnet AZ1"
  type        = string
  default     = "10.0.4.0/24"
}

variable "public_subnet_az2" {
  description = "Public Subnet AZ2"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_app_subnet_az2" {
  description = "Private App Subnet AZ2"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_data_subnet_az2" {
  description = "Private Data Subnet AZ2"
  type        = string
  default     = "10.0.5.0/24"
}
