{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [ "s3:ListBucket" ],
            "Resource": "arn:aws:s3:::${conf_bucket}"
        },
        {
            "Effect": "Allow",
            "Action": [ "s3:GetObject", "s3:ListObjects" ],
            "Resource": "arn:aws:s3:::${conf_bucket}/*"
        }
    ]
}