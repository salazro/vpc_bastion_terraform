output "access" {
  value     = local.db_creds.access_key
  sensitive = true
}

output "secret" {
  value     = local.db_creds.secret_key
  sensitive = true
}