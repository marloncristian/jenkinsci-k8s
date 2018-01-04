FROM jenkins/jenkins

MAINTAINER Marlon Cristian Pereira <marloncristian@gmail.com>

USER root

##--------------------------------------------------------------------------------------------------------------------------------
## install dependencies
##--------------------------------------------------------------------------------------------------------------------------------
RUN apt-get update
RUN apt-get -y install curl libunwind8 gettext apt-transport-https ca-certificates gnupg2 software-properties-common

##--------------------------------------------------------------------------------------------------------------------------------
## install dotnet 
##--------------------------------------------------------------------------------------------------------------------------------
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

RUN sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN apt-get update
RUN apt-get -y install dotnet-sdk-2.0.0

##--------------------------------------------------------------------------------------------------------------------------------
## install docker
##--------------------------------------------------------------------------------------------------------------------------------
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository "deb [arch=amd64] http://download.docker.com/linux/debian stretch stable"
RUN apt-get update
RUN apt-get -y install docker-ce

##--------------------------------------------------------------------------------------------------------------------------------
## install kubectl
##--------------------------------------------------------------------------------------------------------------------------------
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl