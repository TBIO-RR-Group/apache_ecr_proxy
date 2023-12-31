# apache_ecr_proxy

A simple [Apache2](https://httpd.apache.org/)-based proxy for [AWS ECR](https://aws.amazon.com/ecr/). I wanted to make use of ECR as our Docker registry, but wanted people to be able to pull from it (inside our VPC) without having to authenticate against ECR (just pull like you can do using the [Docker private registry](https://distribution.github.io/distribution/)). I.e. ECR requires you to authenticate against it using docker login before you can pull, but we didn't want to have users do that. So I created this code to enable it. It proxies Docker requests onto ECR (passing AWS credentials, i.e. AWS ECR authorization token, on the user's behalf along with the request). It re-gets the authorization token every 6 hours and then restarts Apache (after updating Apache config files with the new token info). It runs itself as a Docker container (so Dockerfile included). You will also need a TLS certificate for this to work (configure in the Makefile).

A Makefile is included to build and run (but you will need to modify it with your own values for AWS credentials, etc.) E.g.

`make build`\
`make run`\
etc.
