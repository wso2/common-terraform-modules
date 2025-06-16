resource "local_file" "db_setup_script" {
  content  = templatefile("${var.tpl_file_path}${var.db_file_name}.tpl", var.template_replacement_values)
  filename = "${var.sql_file_path}${var.db_file_name}.sql"
}

resource "null_resource" "apim_db_setup" {
  triggers = {
    file     = filesha1("${var.tpl_file_path}${var.db_file_name}.tpl")
    password = sha256(values(var.template_replacement_values)[0])
  }
  provisioner "local-exec" {
    command     = <<-EOF
            sqlcmd -S ${var.db_hostname} -U ${var.db_username} -P "${var.db_password}" -d ${var.db_primary_db} -i ${var.sql_file_path}${var.db_file_name}.sql -C
			EOF
    interpreter = ["bash", "-c"]
  }
  depends_on = [local_file.db_setup_script]
}
