terraform {
    required_providers {
        confluent = {
	        source = "confluentinc/confluent"
            version = "2.2.0"
        }
        # aias    = "confluent"
    }

}

variable "cluster_name" {
  description = "The name of the Kafka cluster"
  type        = string
}

variable "topic_name" {
  description = "The name of the Kafka topic"
  type        = string
}


provider "confluent" {
    confluent_cloud_api_key    = var.api_key    # optionally use CONFLUENT_CLOUD_API_KEY env var
    confluent_cloud_api_secret = var.api_secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}
variable "api_key" {
    description = "this is the api key"
    type = string
    }
variable "api_secret" {
    description = "this is the secret key passed via terraform"
    sensitive = true
    type = string
}
module "kafka"{
    source = "../terraform/confluent_module_directory"
    api_key = var.api_key
    api_secret = var.api_secret
    topic_name = var.topic_name
    cluster_name = var.cluster_name
}
# output "cluster_id" {
#     value = module.kafka.kcluster_id
# }
