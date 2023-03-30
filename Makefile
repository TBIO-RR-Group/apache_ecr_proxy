NAME=apache_ecr_proxy
VERSION=latest
REGISTRY=<YOUR REGISTRY HERE>
ECR_REGISTRY=<YOUR ECR REGISTRY HERE>
PLATFORM_ARG=--platform linux/amd64
AWS_SECRET_ACCESS_KEY=<YOUR AWS SECRET ACCESS KEY HERE>
AWS_ACCESS_KEY_ID=<YOUR AWS ACCESS KEY ID HERE>
AWS_DEFAULT_REGION=<YOUR AWS DEFAULT REGION HERE e.g. us-east-1>
CERT_FILE=<FULL PATH TO YOUR TLS CERT FILE HERE>
KEY_FILE=<FULL PATH TO YOUR TLS KEY FILE HERE>

AWS_ARGS=-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
CERTS_ARGS=-v ${CERT_FILE}:/etc/ssl/certs/domain.crt -v ${KEY_FILE}:/etc/ssl/certs/domain.key
RUN_ARGS= --rm -p 80:80 -p 443:443 ${AWS_ARGS} ${CERTS_ARGS}
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
	docker run -d ${RUN_ARGS} ${REGISTRY}/${NAME}:${VERSION}

shell:
	docker run -it ${RUN_ARGS} ${SHELL_EXTRA_ARGS} --entrypoint /bin/bash ${REGISTRY}/${NAME}:${VERSION}

#Got from here: https://forums.docker.com/t/how-to-remove-none-images-after-building/7050/3
dockerrmi:
	docker rmi $(docker images -f 'dangling=true' -q)
