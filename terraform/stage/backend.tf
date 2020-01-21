terraform {
  backend "gcs" {
    bucket = "rezvit-bucket"
    prefix = "tf-state-shared"
  }
}
