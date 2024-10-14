# module "compute" {
#   source = "./modules/compute"
# }

# module "database" {
#   source = "./modules/database"
# }

# module "functions" {
#   source   = "./modules/functions"
#   location = var.region
# }

# module "storage" {
#   source = "./modules/storage"
# }

# module "kms" {
#   source = "./modules/kms"
# }

module "iam" {
  source = "./modules/iam"
  project = var.project
}