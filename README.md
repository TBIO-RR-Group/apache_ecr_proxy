# apache_ecr_proxy
A simple Apache-based proxy for AWS ECR

Build the image simply like this:
docker build -t apache_ecr_proxy:latest .

Run like this:
docker run -d --rm -p 80:80 -p 443:443 -e AWS_SECRET_ACCESS_KEY=... -e AWS_ACCESS_KEY_ID=... -e AWS_DEFAULT_REGION=us-east-1 -v /home/ec2-user/certs/domain.crt:/etc/ssl/certs/domain.crt -v /home/ec2-user/certs/domain.key:/etc/ssl/certs/domain.key apache_ecr_proxy:latest

A Makefile is also included to build and run (but you will need to modify it with your own values for AWS credentials, etc.)