
/* variable "project_name" {
    default = "jenkins"
}

variable "environment" {
    default = "master"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "jenkins_tags" {
    default = {
        Component = "jenkins"
    }
}
 */
# mandatory, user should supply
variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
}

# Optional, default value is t3.micro. User can always override
# t3.micro, t3.medium, t3.small
variable "instance_type" {
    default = "t2.small" 
    }

variable "instance_type_agent" {
    default = "t2.micro" 
    }