FROM ubuntu
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /nvm
ENV NODE_VERSION 14.13.1

# Install nvm with node and npm
RUN mkdir /nvm \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.36.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ADD . /app
WORKDIR /app
RUN ["/bin/bash", "-c", "npm install"]
RUN mkdir workspaces
RUN npm run setup
CMD /bin/bash
