resource "random_password" "howestprime_random_password_generator" {
  length             = 16
  special            = true
  override_special   = "_%@"
}

