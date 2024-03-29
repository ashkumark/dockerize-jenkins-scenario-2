
#FROM maven:3.8.2-openjdk-8

FROM jenkins/jenkins:lts
LABEL maintainer="ash"

WORKDIR /home/docker-jenkins-test
COPY src /home/docker-jenkins-test/src
COPY pom.xml /home/docker-jenkins-test

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log"

USER root

RUN apt-get update
RUN apt-get install -y wget curl unzip sudo maven --no-install-recommends

RUN mkdir /var/log/jenkins
RUN chown -R  jenkins:jenkins /var/log/jenkins

#Docker
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.03.1-ce
ENV DOCKER_API_VERSION 1.27
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

RUN groupadd docker
RUN usermod -aG docker jenkins
#RUN reboot
 
USER jenkins

# Expose ports
EXPOSE 5901