FROM alpine:3.10

RUN apk add --no-cache aspell aspell-en aspell-ru

COPY "entrypoint.sh" "/"

ENTRYPOINT ["/entrypoint.sh"]
