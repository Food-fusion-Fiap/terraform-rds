variable "region" {
  description = "The region where resources will be created and state will be stored"
  default     = "us-east-1"
}

variable "db_password" {
  description = "Password for the database"
  default     = ""
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database"
  default     = "postgres"
}

variable "db_username" {
  description = "The username for the database"
  default     = "postgres"
}

variable "project_name" {
  description = "The name of the project"
  default     = "food_fusion"
}
