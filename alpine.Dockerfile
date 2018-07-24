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

FROM nginx:alpine
COPY --from=builder /usr/local/src/clustercode-admin/dist /usr/share/www
