variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "ci-cd-demo"
}

variable "container_port" {
  description = "Container/app port"
  type        = number
  default     = 5000
}
