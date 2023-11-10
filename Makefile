NAME=apache_ecr_proxy
VERSION=latest
REGISTRY=<ECR_PROXY_DOMAIN_AND_PORT>
ECR_REGISTRY=<YOUR_AWS_ACCOUNT_ID>.dkr.ecr.<YOUR_AWS_REGION>.amazonaws.com
LISTEN_PORT=<PORT THE ECR PROXY WILL LISTEN ON>
PLATFORM_ARG=--platform linux/amd64
AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET ACCESS KEY>
AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY>
AWS_DEFAULT_REGION=<YOUR AWS REGION>
CERT_FILE=/path/to/cert/cert.crt
KEY_FILE=/path/to/key/cert.key

AWS_ARGS=-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
CERTS_ARGS=-v ${CERT_FILE}:/etc/ssl/certs/domain.crt -v ${KEY_FILE}:/etc/ssl/certs/domain.key
RUN_ARGS= --rm -p ${LISTEN_PORT}:${LISTEN_PORT} ${AWS_ARGS} ${CERTS_ARGS}
SHELL_EXTRA_ARGS=-v ${PWD}:${PWD} -w ${PWD}


build: 
	docker build ${PLATFORM_ARG} -t ${REGISTRY}/${NAME}:${VERSION} -t ${ECR_REGISTRY}/${NAME}:${VERSION} \
                        -t ${NAME}:${VERSION} \
                        -f Dockerfile .

buildfresh: 
	docker build ${PLATFORM_ARG} -t ${REGISTRY}/${NAME}:${VERSION}  -t ${ECR_REGISTRY}/${NAME}:${VERSION} --no-cache \
                        -t ${NAME}:${VERSION} \
                        -f Dockerfile .

run:
	docker run -d ${RUN_ARGS} ${REGISTRY}/${NAME}:${VERSION} /entrypoint.sh ${LISTEN_PORT}

shell:
	docker run -it ${RUN_ARGS} ${SHELL_EXTRA_ARGS} --entrypoint /bin/bash ${REGISTRY}/${NAME}:${VERSION}
