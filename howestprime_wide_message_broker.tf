resource "cloudamqp_instance" "howestprime_cloudamqp_instance" {
    name    = var.howestprime_cloudamqp_resource_names["message_broker_name_howestprime"]
    plan    = "lemming"
    region  = "amazon-web-services::eu-west-1"
    tags    = ["terraform"]
}

data "cloudamqp_credentials" "local-admin" {
    instance_id = cloudamqp_instance.howestprime_cloudamqp_instance.id
}