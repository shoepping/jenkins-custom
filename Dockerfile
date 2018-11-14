FROM jenkins/jenkins:2.138.3

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Skip setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
