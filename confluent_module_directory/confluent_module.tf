
terraform {
    required_providers {
        confluent = {
	        source = "confluentinc/confluent"
            version = "2.2.0"
        }
    }
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



provider "confluent" {
}

resource "confluent_environment" "dev_env"{
    display_name = "dev_env"
}

variable "cluster_name"{
    description = "cluster Name"
    type = string
}
variable "topic_name"{
    description = "topic name"
    type = string
}
resource "confluent_kafka_cluster" "dev" {
    
    display_name = var.cluster_name
    availability = "SINGLE_ZONE"
    cloud = "AWS"
    region = "us-east-1"
    basic {}
    environment {
        id = confluent_environment.dev_env.id
    } 
    
}
resource "confluent_service_account" "serviceaccount"{
    provider     = confluent
    display_name = "serviceaccount"
}
resource "confluent_role_binding" "saccount_binding"{
    provider     = confluent
    principal   = "User:${confluent_service_account.serviceaccount.id}"
    role_name   = "CloudClusterAdmin"
    crn_pattern = confluent_kafka_cluster.dev.rbac_crn

}
resource "confluent_api_key" "kafka_cluster_api_key"{
    provider     = confluent
    display_name = "kafka_cluster_api_key"
    owner {
        id          = confluent_service_account.serviceaccount.id
        api_version = confluent_service_account.serviceaccount.api_version
        kind        = confluent_service_account.serviceaccount.kind
    }
    managed_resource {
        id          = confluent_kafka_cluster.dev.id
        api_version = confluent_kafka_cluster.dev.api_version
        kind        = confluent_kafka_cluster.dev.kind

    environment {
      id = confluent_environment.dev_env.id
    }
  }
}

resource "confluent_kafka_topic" "mytopic" {
    provider     = confluent
    kafka_cluster {
        id = confluent_kafka_cluster.dev.id
    }
    topic_name = var.topic_name
    partitions_count = 6
    config = {
        name = "cleanup.policy"
        value = "compact"
    }
    rest_endpoint = confluent_kafka_cluster.dev.rest_endpoint
    credentials {
        key    = confluent_api_key.kafka_cluster_api_key.id
        secret = confluent_api_key.kafka_cluster_api_key.secret
  }
    

}
output "kcluster_id"{
    value = confluent_kafka_cluster.dev.id
}