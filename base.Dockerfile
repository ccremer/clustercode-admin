FROM node:alpine

WORKDIR /usr/local/src/clustercode-admin

ADD package*.json ./

RUN \
  npm install
