FROM jenkins/jenkins:latest

USER root

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl git && \
    curl -sSL https://get.docker.com/ | sh && \
    usermod -aG docker jenkins

COPY jenkins/jenkins.yml /usr/share/jenkins/ref/casc_config/
COPY jenkins/plugins.txt /usr/share/jenkins/ref/
COPY jenkins/job_dsl.groovy /usr/share/jenkins/init.groovy.d/
COPY jenkins/linkproject.sh /usr/bin/

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt