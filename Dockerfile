FROM alpine AS hugo
RUN apk add --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
  hugo
RUN apk add --no-cache git tree

ARG HUGOPATH=/data
COPY . $HUGOPATH
WORKDIR $HUGOPATH
RUN ./get-themes.sh
RUN ./build.sh
RUN mkdir -p /data/webroot
RUN cp -r $HUGOPATH/output/* /data/webroot/

FROM scratch
COPY --from=build /data /data
