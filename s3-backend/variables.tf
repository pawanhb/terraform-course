variable "company" {
  type        = string
  description = "company name"
}

variable "project_id" {
  type        = string
  description = "value of project id"
}

variable "cost_center" {
  type        = string
  description = "cost center value"
  default     = "CC-12345"
}