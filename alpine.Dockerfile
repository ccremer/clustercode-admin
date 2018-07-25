# Builder Image
FROM braindoctor/clustercode-admin:base as builder

ADD build ./build
ADD config ./config
ADD static ./static
ADD .babelrc .editorconfig .eslintignore .eslintrc.js .postcssrc.js index.html ./
ADD src ./src
ADD test ./test

RUN \
  ls -lah && \
  npm run build && \
  npm run test && \
  ls -lah

# Runtime Image
FROM nginx:alpine

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/clustercode.conf /etc/nginx/conf.d/
COPY --from=builder /usr/local/src/clustercode-admin/dist /usr/share/nginx/html
