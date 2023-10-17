
#FROM maven:3.8.2-openjdk-8

FROM jenkins/jenkins:lts
LABEL maintainer="ash"

WORKDIR /home/docker-jenkins-test
COPY src /home/docker-jenkins-test
COPY pom.xml /home/docker-jenkins-test

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log"

USER root

RUN mkdir /var/log/jenkins
RUN chown -R  jenkins:jenkins /var/log/jenkins

#Docker 
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
   
RUN apt-get update -y && \
    apt-cache policy docker-ce	&& \
    apt-get install -y docker-ce docker-ce-cli containerd.io
 
USER jenkins

# Expose ports
EXPOSE 5901