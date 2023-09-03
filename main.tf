module "domain" {
  source      = "./modules/domain"
  domain_name = var.ctf_domain_name
  email       = var.cloudflare_email
}