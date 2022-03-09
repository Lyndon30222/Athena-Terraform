variable "athena_columns" {
  default = {
    name    = "string"
    age     = "int"
    game    = "string"
    console = "string"
  }
}

variable "project_name" {
  default = "my-new-project"
}