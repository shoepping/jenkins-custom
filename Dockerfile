FROM jenkins/jenkins:2.235.5

# https://github.com/docker/docker-ce/releases
ENV DOCKER_VERSION=19.03.8
# https://github.com/docker/compose/releases
ENV DOCKER_COMPOSE_VERSION=1.26.2

# JENKINS_VERSION defined in parent image
LABEL DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION} \
      DOCKER_VERSION=${DOCKER_VERSION} \
      JENKINS_VERSION=${JENKINS_VERSION}

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root
RUN apt-get update
RUN apt-get install -y curl zip wget

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    jq \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update
RUN apt-cache madison docker-ce

ENV DEBIAN_DOCKER_VERSION=5:${DOCKER_VERSION}~3-0~debian-stretch

RUN apt-get install -y \
        docker-ce=${DEBIAN_DOCKER_VERSION} \
        docker-ce-cli=${DEBIAN_DOCKER_VERSION} \
        containerd.io

RUN usermod -aG docker jenkins

RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

USER jenkins

# Skip setup wizard & configure content security content (for jmeter report plugin)
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts; default-src 'self'; script-src * 'unsafe-eval'; img-src *; style-src * 'unsafe-inline'; font-src *\""
