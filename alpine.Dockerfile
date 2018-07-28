# Builder Image
FROM braindoctor/clustercode-admin:builder as builder

ADD build ./build
ADD config ./config
ADD static ./static
ADD .babelrc .editorconfig .eslintignore .eslintrc.js .postcssrc.js index.html ./
ADD src ./src
ADD test ./test

#ARG \
#  PHANTOMJS_BIN=/usr/local/src/clustercode-admin/node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs

RUN \
  env | sort && \
  ls -lah && \
  npm run build
  # This does not work: PhantomJS gets a timeout. Adding PHANTOMJS_BIN env does not work either.
  # npm run unit

# Runtime Image
FROM nginx:alpine

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/clustercode.conf /etc/nginx/conf.d/
COPY --from=builder /usr/local/src/clustercode-admin/dist /usr/share/nginx/html
