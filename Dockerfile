FROM jenkins/jenkins:latest

USER root

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y curl && \
    curl -sSL https://get.docker.com/ | sh && \
    usermod -aG docker jenkins

COPY jenkins/jenkins.yml /usr/share/jenkins/ref/casc_config/jenkins.yml
COPY jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY jenkins/job_dsl.groovy /usr/share/jenkins/init.groovy.d/job_dsl.groovy

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt