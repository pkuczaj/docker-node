FROM centos:7
MAINTAINER Peter Kuczaj <peter.kuczaj@appdirect.com>
ENV NODEJS_VERSION=v8.15.0
ENV PATH=/apps/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin

ADD run-node.sh /

# && npm set registry https://artifactory.appcarousel.com/api/npm/npm \

RUN mkdir -p /var/run/lock \
 && yum -y update \
 && yum -y install ca-certificates git \
 && mkdir /apps \
 && cd /apps \
 && curl -s -L -O https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && tar xf node-${NODEJS_VERSION}-linux-x64.tar.xz \
 && mv node-${NODEJS_VERSION}-linux-x64 node \
 && yum clean all \
 && useradd -c 'John Doe' -d /dev/null -s /bin/false -M -u 1999 john

RUN npm install -g \
        grunt-cli \
        grunt-init \
        jq \
        mocha \
        npm-check-updates \
        semver \
 && npm set registry https://artifactory.appcarousel.com/api/npm/npm \
 && npm cache verify \
 && mkdir -p /node \
 && npm set progress=false \
 && npm set prefix /usr/local \
 && chmod +x /run-node.sh

VOLUME [ "/node" ]

WORKDIR "/node"

CMD [ "/run-node.sh" ]
