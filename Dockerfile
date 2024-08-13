FROM jenkins/jenkins:2.471-jdk17

# https://github.com/moby/moby/releases
ENV DOCKER_VERSION=26.1.4
# https://github.com/docker/compose/releases
ENV DOCKER_COMPOSE_VERSION=2.29.2

# JENKINS_VERSION defined in parent image
LABEL DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION} \
      DOCKER_VERSION=${DOCKER_VERSION} \
      JENKINS_VERSION=${JENKINS_VERSION}

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

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN add-apt-repository \
    "deb [arch=amd64] https://apt.releases.hashicorp.com \
    $(lsb_release -cs) \
    main"

RUN apt-get update
RUN apt-get install -y terraform

ENV DEBIAN_DOCKER_VERSION=5:${DOCKER_VERSION}-1~debian.12~bookworm

RUN apt-get install -y \
        docker-ce=${DEBIAN_DOCKER_VERSION} \
        docker-ce-cli=${DEBIAN_DOCKER_VERSION} \
        containerd.io

RUN usermod -aG docker jenkins

RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# -Djenkins.install.runSetupWizard=false -> skip setup wizard
# -Dorg.jenkinsci.plugins.docker.workflow.client.DockerClient.CLIENT_TIMEOUT=240 -> this is an attempt to fix java.io.IOException: Failed to rm container
# see https://issues.jenkins-ci.org/browse/JENKINS-42322?focusedCommentId=327839&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-327839
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dorg.jenkinsci.plugins.docker.workflow.client.DockerClient.CLIENT_TIMEOUT=240"
