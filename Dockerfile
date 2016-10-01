FROM alpine:3.4
MAINTAINER Jon Jagger <jon@jaggersoft.com>
USER root

ARG  DOCKER_VERSION
ARG  DOCKER_COMPOSE_VERSION

ARG  SCRIPT=install.sh
COPY ${SCRIPT} .
RUN  chmod +x ./${SCRIPT} \
   ; sync \
   ; ./${SCRIPT} ${DOCKER_VERSION} ${DOCKER_COMPOSE_VERSION} \
   ; sync \
   ; rm ./${SCRIPT}

ARG HOME_DIR=/app
RUN mkdir ${HOME_DIR}
COPY . ${HOME_DIR}
WORKDIR ${HOME_DIR}



