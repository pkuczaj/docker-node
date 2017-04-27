FROM centos:7
MAINTAINER Peter Kuczaj <peter.kuczaj@appdirect.com>
ENV NODEJS_VERSION=v4.3.1
ENV PATH=/apps/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin

WORKDIR /node

RUN yum -y install make gcc gcc-c++ \
 && yum -y clean all
RUN mkdir /apps \
 && cd /apps \
 && curl -s -L -O https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && tar xf node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && mv node-${NODEJS_VERSION}-linux-x64 node

RUN npm set registry https://artifactory.appcarousel.com/api/npm/npm \
 && npm install -g grunt-cli \
 && yum install -g mocha

CMD "npm start"
