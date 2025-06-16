variable "tpl_file_path" {
  description = "Path to the template file"
  type        = string
  default     = "./mssql-scripts/"
}
variable "sql_file_path" {
  description = "Path to the SQL file"
  type        = string
  default     = "/tmp/"
}
variable "db_file_name" {
  description = "Name of the SQL file"
  type        = string
}
variable "db_password" {
  description = "Password for the main database"
  type        = string
  sensitive   = true
}
variable "db_hostname" {
  description = "Hostname of the database"
  type        = string
}
variable "db_username" {
  description = "Username for the database"
  type        = string
}
variable "db_primary_db" {
  description = "Primary database name"
  type        = string
  default     = "master"
}
variable "template_replacement_values" {
  description = "Values to replace in the template"
  type        = map(string)
  sensitive   = true
}