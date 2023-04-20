data "aws_secretsmanager_secret_version" "credential" {
  secret_id = github_actions
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.credential.secret_string)
}
