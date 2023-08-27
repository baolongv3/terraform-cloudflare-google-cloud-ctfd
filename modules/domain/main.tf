resource "cloudflare_zone" "ctfd" {
  account_id = data.cloudflare_accounts.account.accounts[0].id
  zone       = var.domain_name
}

resource "cloudflare_api_token" "api_token" {
    depends_on = [ cloudflare_zone.ctfd ]
    name = "ctfd_externalDNS_token"
    policy {
        permission_groups = [
            data.cloudflare_api_token_permission_groups.all.zone["DNS Write"]
        ]


        resources = {
            "com.cloudflare.api.account.zone.${cloudflare_zone.ctfd.id}" =  "*"
        }
        effect = "allow"
    }
}

resource "cloudflare_filter" "filter" {
  for_each    = var.firewall_rules
  zone_id     = cloudflare_zone.ctfd.id
  description = each.value.description
  expression  = each.value.expression
}

resource "cloudflare_firewall_rule" "rule" {
    for_each    = var.firewall_rules
    zone_id     = cloudflare_zone.ctfd.id
    filter_id   = cloudflare_filter.filter[each.key]
    action      = each.value.action  
}


