FROM alpine:3.7
RUN apk add --no-cache git openssh-client openssl

COPY ./entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]