FROM centos:7
MAINTAINER Peter Kuczaj <peter.kuczaj@appdirect.com>
ENV NODEJS_VERSION=v6.9.5
ENV PATH=/apps/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin

ADD run-node.sh /

WORKDIR /node

RUN yum -y install make gcc gcc-c++ \
 && yum -y clean all \
 && mkdir /apps \
 && cd /apps \
 && curl -s -L -O https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && tar xf node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && mv node-${NODEJS_VERSION}-linux-x64 node \
 && npm set registry https://artifactory.appcarousel.com/api/npm/npm \
 && npm set prefix /usr/local \
 && npm install -g grunt \
 && npm install -g grunt-cli \
 && npm install -g mocha \
 && chmod +x /run-node.sh \
 && useradd john

CMD [ "/run-node.sh" ]
