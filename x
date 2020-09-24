[
  {
    "name": "${CONTAINER_NAME}",
    "image": "",
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
        "containerPort": 1080,
        "hostPort": 1080,
        "protocol": "tcp"
      }
    ]
  }
]
