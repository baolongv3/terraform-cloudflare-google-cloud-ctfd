output "api_token" {
    value = cloudflare_api_token.api_token.value
    sensitive = true
}