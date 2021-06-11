terraform {
  backend "gcs" {
    bucket = "tf-anthos-labs"
    prefix = "terraform_tfstate"
  }
}
