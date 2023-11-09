NAME=apache_ecr_proxy
VERSION=latest
REGISTRY=docker.rdcloud.bms.com:443
ECR_REGISTRY=483421617021.dkr.ecr.us-east-1.amazonaws.com
LISTEN_PORT=443
PLATFORM_ARG=--platform linux/amd64
AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY_HERE>
AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_HERE>
AWS_DEFAULT_REGION=us-east-1
CERT_FILE=/home/ec2-user/certs/new_tls_cert_230315/docker_rdcloud_bms_com_384850493/docker_rdcloud_bms_com.crt
KEY_FILE=/home/ec2-user/certs/new_tls_cert_230315/docker.rdcloud.bms.com.key

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
