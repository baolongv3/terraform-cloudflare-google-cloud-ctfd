variable "domain_name" {
    description = "Domain name to host CTF With"
    type = string
}

variable "email" {
    description = "Email of domain creator for automatically creating zone"
    type = string
}

variable "firewall_rules" {
    description = "Cloudflare filter for domain"
    type = map(object({
        description = optional(string)
        expression = optional(string)
        action = optional(string)
    }))
    default = {}
}