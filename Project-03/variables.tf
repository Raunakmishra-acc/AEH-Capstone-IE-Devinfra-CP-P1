variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "cpu_threshold" {
  description = "CPU % that triggers the alarm"
  default     = 70
}

variable "alert_email" {
  description = "Email for SNS alarm notifications"
  type        = string
}
