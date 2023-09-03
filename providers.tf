provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email   = var.cloudflare_email
}

provider "google" {
    project     = "my-project-id"
    region      = "us-central1"
}