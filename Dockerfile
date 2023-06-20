FROM maven:3.8-jdk-11

ENV NODE_VERSION=18.0.0
ENV NVM_DIR=/root/.nvm
ENV CF_CLI_VERSION="7.7.1"
ENV YQ_VERSION="4.26.1"

RUN apt update
RUN apt upgrade -y
RUN apt install -y git curl python-is-python3 pip zip
RUN curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh" | bash
RUN curl -fL "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}" | tar -zx -C /usr/local/bin
RUN curl -fL "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64" -o /usr/local/bin/yq
RUN chmod +x /usr/local/bin/*
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION} && \
    nvm use v${NODE_VERSION} && \
    nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
