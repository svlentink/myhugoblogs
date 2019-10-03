FROM svlentink/hugo-build AS build

ARG HUGOPATH=/data
COPY . $HUGOPATH
WORKDIR $HUGOPATH
#RUN ./get-themes.sh # now done in build container
RUN ./build.sh
RUN mkdir -p /data/webroot
RUN cp -r $HUGOPATH/output/* /data/webroot/

FROM scratch
COPY --from=build /data /data
