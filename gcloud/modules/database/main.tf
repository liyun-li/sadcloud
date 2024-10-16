resource "google_sql_database_instance" "insecure_mysql_instance" {
  name                = "insecure-mysql-database"
  database_version    = "MYSQL_5_6"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"

    # https://cloud.google.com/sql/docs/mysql/flags
    # 6.1.1 Ensure That the 'Local_infile' Database Flag for a Cloud SQL MySQL Instance Is Set to 'Off'
    database_flags {
      name  = "local_infile"
      value = "on"
    }
    # 6.5.4 Ensure 'Skip_show_database' Database Flag for Cloud SQL MySQL Instance Is Set to 'On'
    database_flags {
      name  = "skip_show_database"
      value = "off"
    }
  }
}

resource "google_sql_database_instance" "insecure_postgres_instance" {
  name                = "insecure-postgres-database"
  database_version    = "POSTGRES_9_6"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
    # https://cloud.google.com/sql/docs/postgres/flags
    # 6.15.2 Ensure That the 'log_connections' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'On'
    database_flags {
      name  = "log_connections"
      value = "off"
    }
    # 6.15.3 Ensure That the 'log_disconnections' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'On'
    database_flags {
      name  = "log_disconnections"
      value = "off"
    }
    # 6.15.4 Ensure that the 'log_min_messages' Flag for a Cloud SQL PostgreSQL Instance is set at minimum to 'Warning'
    database_flags {
      name  = "log_min_messages"
      value = "panic"
    }
    # 6.15.5 Ensure 'log_min_error_statement' Database Flag for Cloud SQL PostgreSQL Instance Is Set to 'Error' or Stricter
    database_flags {
      name  = "log_min_error_statement"
      value = "panic"
    }
    # 6.15.6 Ensure That the 'log_min_duration_statement' Database Flag for Cloud SQL PostgreSQL Instance Is Set to '-1' (Disabled)
    database_flags {
      name  = "log_min_duration_statement"
      value = 2147483647
    }
    # 6.15.7 Ensure That 'cloudsql.enable_pgaudit' Database Flag for each Cloud SQL PostgreSQL Instance Is Set to 'on' For Centralized Logging
    database_flags {
      name  = "cloudsql.enable_pgaudit"
      value = "off"
    }
  }
}

resource "google_sql_database_instance" "insecure_sqlserver_instance" {
  name             = "insecure-sqlserver-instance"
  database_version = "SQLSERVER_2019_STANDARD"
  root_password    = "INSERT-PASSWORD-HERE"

  settings {
    tier = "db-custom-2-7680"

    # https://cloud.google.com/sql/docs/sqlserver/flags
    # 6.2.1 Ensure 'external scripts enabled' database flag for Cloud SQL SQL Server instance is set to 'off'
    database_flags {
      name  = "external scripts enabled"
      value = "on"
    }
    # 6.5.5 Ensure that the 'cross db ownership chaining' database flag for Cloud SQL SQL Server instance is set to 'off' (deprecated)
    # database_flags {
    #   name  = "cross db ownership chaining"
    #   value = "on"
    # }
    # 6.5.6 Ensure that the 'contained database authentication' database flag for Cloud SQL on the SQL Server instance is set to 'off'
    database_flags {
      name  = "contained database authentication"
      value = "on"
    }
    # 6.6.1 Ensure 'user options' database flag for Cloud SQL SQL Server instance is not configured
    # https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-user-options-server-configuration-option
    database_flags {
      name  = "user options"
      value = 513 # NOCOUNT (512) + DISABLE_DEF_CNST_CHK (1)
    }
    # 6.6.2 Ensure '3625 (trace flag)' database flag for all Cloud SQL Server instances is set to 'on'
    database_flags {
      name  = "3625"
      value = "off"
    }
    # 6.6.2 Ensure 'remote access' database flag for Cloud SQL SQL Server instance is set to 'off'
    database_flags {
      name  = "remote access"
      value = "on"
    }
  }
  deletion_protection = false
}

# 6.3.4 Ensure That the Cloud SQL Database Instance Requires All Incoming Connections To Use SSL
# 6.5.3 Ensure That Cloud SQL Database Instances Do Not Implicitly Whitelist All Public IP Addresses
# 6.8.1 Ensure Instance IP assignment is set to private
# 6.9.1	Ensure That a MySQL Database Instance Does Not Allow Anyone To Connect With Administrative Privileges
