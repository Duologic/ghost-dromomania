terraform {
  backend "s3" {
    endpoint                    = "https://ams3.digitaloceanspaces.com"
    region                      = "us-west-1"                           # Basically this gets ignored.
    bucket                      = "terraform-remote-state"
    key                         = "dromomania.tfstate"
    profile                     = "digitalocean"
    skip_requesting_account_id  = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
  }
}

provider "digitalocean" {
  version = "~> 1.1"
}
