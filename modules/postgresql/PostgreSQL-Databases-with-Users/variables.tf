# -------------------------------------------------------------------------------------
#
# Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

variable "databases" {
  description = "Map of databases and the users who have permissions on them"
  type = map(object({
    read_only_users  = list(string)
    read_write_users = list(string)
    # DDL users get everything read-write users get, plus ALTER/DROP on the
    # database's objects via membership in the database's owner role. Requires
    # per_database_owner = true.
    ddl_users  = optional(list(string), [])
    extensions = optional(list(string), [])
  }))
  default = {
    primary_db = {
      read_only_users  = ["data_analyst"]
      read_write_users = ["app_backend"]
    }
    reporting_db = {
      read_only_users  = ["data_analyst", "app_backend"]
      read_write_users = []
    }
  }

  validation {
    condition     = var.per_database_owner || alltrue([for db, config in var.databases : length(config.ddl_users) == 0])
    error_message = "ddl_users requires per_database_owner = true."
  }

  # A DDL user's sessions switch to its database's owner role at login
  # (assume_role is role-wide, not per database), so it must not appear in any
  # other database, nor in another list of the same database.
  validation {
    condition = alltrue([
      for user in flatten([for db, config in var.databases : config.ddl_users]) :
      length(flatten([
        for db, config in var.databases :
        [for u in concat(config.read_only_users, config.read_write_users, config.ddl_users) : u if u == user]
      ])) == 1
    ])
    error_message = "Each DDL user must belong to exactly one database and appear in only one of its user lists."
  }
}

variable "db_owner_role_name" {
  description = "The name of the role that will own all the databases."
  type        = string
}

variable "db_owner_member_users" {
  description = "Users from the databases map to be granted membership in the db owner role, e.g. to run schema migrations."
  type        = list(string)
  default     = []
}

variable "per_database_owner" {
  description = <<-EOT
    When true, each database gets its own NOLOGIN owner role "<db>_owner" that owns
    the database's objects. db_owner_role_name stays the database owner, is an
    ADMIN member of every <db>_owner (so it reaches every database's objects with
    one login), and its sessions in each database switch to that database's owner
    role automatically — so objects it creates are owned by <db>_owner. DDL users
    are members of their database's owner role and switch to it at login.
    Objects that existed before enabling this must be re-owned to <db>_owner
    out of band (ALTER ... OWNER TO), or DDL users cannot alter them.
  EOT
  type        = bool
  default     = false
}

variable "db_admin_connection" {
  description = <<-EOT
    Admin connection used to run the per-database role setting for
    db_owner_role_name (ALTER ROLE ... IN DATABASE ... SET role), which the
    PostgreSQL provider cannot express. Run through psql, so psql must be on the
    machine running Terraform. Required when per_database_owner = true.
  EOT
  type = object({
    host     = string
    port     = optional(number, 5432)
    username = string
    password = string
    sslmode  = optional(string, "require")
  })
  default   = null
  sensitive = true

  validation {
    condition     = !var.per_database_owner || var.db_admin_connection != null
    error_message = "db_admin_connection is required when per_database_owner = true."
  }
}
