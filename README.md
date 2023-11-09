# apache_ecr_proxy

A simple Apache2-based proxy for AWS ECR. I wanted to make use of ECR as our Docker registry, but wanted people to be able to pull from it (inside our VPC) without having to authenticate aginst ECR (just pull like you can do using the Docker private registry). I.e. ECR requires you to authenticate against it using docker login before you can pull, but we didn't want to have users do that. So I created this code to enable it. It proxies Docker requests onto ECR (passing AWS credentials, i.e. Docker login token on the user's behalf). It runs itself as a Docker container (so Dockerfile included). You will also need a TLS certificate for this to work (configure in the Makefile).

A Makefile is included to build and run (but you will need to modify it with your own values for AWS credentials, etc.) E.g.

make build
make run
etc.