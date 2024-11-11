FROM jenkins/jenkins:latest

COPY jenkins.yml /usr/share/jenkins/ref/casc_config/jenkins.yml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY job_dsl.groovy /usr/share/jenkins/init.groovy.d/job_dsl.groovy

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt