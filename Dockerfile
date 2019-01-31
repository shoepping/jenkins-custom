FROM jenkins/jenkins:2.150.2

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Skip setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
