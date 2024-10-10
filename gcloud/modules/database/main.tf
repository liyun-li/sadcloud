resource "google_sql_database_instance" "insecure_mysql_instance" {
  name                = "insecure-mysql-database"
  database_version    = "MYSQL_5_6"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database_instance" "insecure_postgres_instance" {
  name                = "insecure-postgres-database"
  database_version    = "POSTGRES_9_6"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
  }
}
