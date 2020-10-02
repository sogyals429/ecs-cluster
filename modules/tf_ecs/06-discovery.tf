resource "aws_service_discovery_private_dns_namespace" "svc_private" {
  name = "${var.aws_region}.compute.internal"
  description = "AWS SVC discovery private DNS namespace"
  vpc = var.vpc_id
}

resource "aws_service_discovery_service" "nginx-proxy-service" {
  name = "nginx-proxy-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.svc_private.id
    dns_records {
      ttl = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}