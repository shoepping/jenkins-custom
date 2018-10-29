FROM shoepping/jenkins:2.138.2

ENV DOCKER_VERSION 18.06.1~ce~3-0~debian

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
     software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update
RUN apt-cache madison docker-ce
RUN apt-get install -y docker-ce=${DOCKER_VERSION}

RUN usermod -aG docker jenkins
USER jenkins


# this is to skip default initialization (create admin user, plugin setup wizard, etc)
RUN echo 2.138.2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.138.2 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
