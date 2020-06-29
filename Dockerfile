FROM nimlang/nim:1.2.2-alpine as build
COPY fileinfo.nim /
RUN nim c --passL:"-static -no-pie" -d:release fileinfo.nim

FROM alpine:3.12
COPY --from=build /fileinfo /usr/local/bin/fileinfo
