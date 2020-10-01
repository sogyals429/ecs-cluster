[
  {
    "name": "${CONTAINER_NAME}",
    "image": "413817614433.dkr.ecr.ap-southeast-2.amazonaws.com/${REGISTRY_IMAGE}",
    "networkMode": "awsvpc",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${LOG_GROUP_NAME}",
          "awslogs-stream-prefix": "ecs-${CONTAINER_NAME}",
          "awslogs-datetime-format": "%Y-%m-%d %H:%M:%S",
          "awslogs-region": "${AWS_REGION}"
        }
    },
  "environment": [
    { "name": "S3_BUCKET", "value": "${CONF_BUCKET}" },
    { "name": "SERVICE_NAME", "value": "${CONTAINER_NAME}" }
    ],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]