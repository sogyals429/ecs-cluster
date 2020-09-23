{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
      "Service": [
         "s3.amazonaws.com",
         "lambda.amazonaws.com",
         "ecs.amazonaws.com",
         "ecs-tasks.amazonaws.com"
       ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}