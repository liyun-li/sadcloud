# App Defense Alliance Cloud Profile
# https://github.com/appdefensealliance/ASA-WG/blob/main/Cloud%20App%20and%20Config%20Profile/Cloud%20App%20and%20Config%20Specification.md

module "storage" {
  source = "./modules/storage"
}

# module "database" {
#   source = "./modules/database"
# }

# module "functions" {
#   source   = "./modules/functions"
#   location = var.region
# }
