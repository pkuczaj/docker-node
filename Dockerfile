FROM centos:7
MAINTAINER Peter Kuczaj <peter.kuczaj@appdirect.com>
ENV NODEJS_VERSION=v6.9.5
ENV PATH=/apps/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin

WORKDIR /node

RUN yum -y install make gcc gcc-c++ \
 && yum -y clean all \
 && mkdir /apps \
 && cd /apps \
 && curl -s -L -O https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && tar xf node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && mv node-${NODEJS_VERSION}-linux-x64 node \
 && npm set registry https://artifactory.appcarousel.com/api/npm/npm \
 && npm install -g grunt grunt-cli  mocha

#npm install -f eslint
#npm install -g jsdoc
#npm install -g istanbul
#npm install -g mkdirp
#npm install -g fixpack
#npm install -g jade

CMD "npm start"
