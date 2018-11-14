FROM jenkins/jenkins:2.138.3

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# this is to skip default initialization (create admin user, plugin setup wizard, etc)
RUN echo 2.138.2 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.138.2 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
