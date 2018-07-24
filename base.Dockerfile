FROM node:8

WORKDIR /usr/local/src/clustercode-admin

ADD package*.json ./

RUN \
  npm install
