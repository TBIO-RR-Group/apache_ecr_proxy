# apache_ecr_proxy
A simple Apache-based proxy for AWS ECR

Run like this:
docker run -it --rm -p 80:80 -p 443:443 -e AWS_SECRET_ACCESS_KEY=... -e AWS_ACCESS_KEY_ID=... -e AWS_DEFAULT_REGION=us-east-1 -v /home/ec2-user/certs/domain.crt:/etc/ssl/certs/domain.crt -v /home/ec2-user/certs/domain.key:/etc/ssl/certs/domain.key apache_ecr_proxy:latest
