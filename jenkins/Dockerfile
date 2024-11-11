FROM jenkins/jenkins:latest

COPY jenkins.yml /usr/share/jenkins/ref/casc_config/jenkins.yml

RUN jenkins-plugin-cli --plugins "configuration-as-code:latest job-dsl:latest cloudbees-folder:latest credentials:latest instance-identity:latest script-security:latest structs:latest role-strategy:latest ws-cleanup:latest"
