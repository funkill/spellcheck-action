FROM alpine:3.10

RUN apk add --no-cache aspell aspell-en aspell-ru findutils

COPY "entrypoint.sh" "/"

ENTRYPOINT ["/entrypoint.sh"]
