terraform {
  # Версия terraform
  required_version = ">=0.12.18"
}

provider "google" {
  # Версия провайдера
  version = "2.15"
  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_project_metadata_item" "app" {
  key = "ssh-keys"
  # путь до публичного ключа
  value = "appuser:${file(var.public_key_path)}"
}

module "app" {
  source = "../modules/app"
}

module "db" {
  source = "../modules/db"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["91.193.179.193/32"]
}
