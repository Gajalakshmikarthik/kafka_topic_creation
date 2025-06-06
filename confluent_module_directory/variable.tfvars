variable "cluster_name"{
    description = "cluster Name"
    type = string
}
variable "topic_name"{
    description = "topic name"
    type = string
}
variable "api_key" {
    description = "this is the api key"
    type = string
    sensitive = true
}
variable "api_secret" {
    description = "this is the secret key passed via terraform"
    sensitive = true
    type = string
}

