[
  {
    "name": "${CONTAINER_NAME}",
    "image": "${REGISTRY_ACCOUNT}.dkr.ecr.${REGISTRY_REGION}.amazonaws.com/${REGISTRY_IMAGE}",
    "networkMode": "awsvpc",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "ecs-svc-logs",
          "awslogs-stream-prefix": "ecs-${CONTAINER_NAME}",
          "awslogs-datetime-format": "%Y-%m-%d %H:%M:%S",
          "awslogs-region": "${AWS_REGION}"
        }
    },
  "environment": [
    { "name": "S3_BUCKET", "value": "${CONF_BUCKET}" },
    { "name": "SERVICE_NAME", "value": "${CONTAINER_NAME}" },
    { "name": "JAVA_MEM", "value": "${JAVA_MEM}" },
    { "name": "AWS_XRAY_DAEMON_ADDRESS", "value": "${AWS_XRAY_DAEMON_ADDRESS}" },
    { "name": "AWS_XRAY_CONTEXT_MISSING", "value": "LOG_ERROR" }
    ],
    "portMappings": [
      {
        "containerPort": 1080,
        "hostPort": 1080,
        "protocol": "tcp"
      }
    ]
  }
]