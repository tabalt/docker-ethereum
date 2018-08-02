FROM ethereum/client-go:alltools-v1.8.13 as builder

FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /usr/local/bin/geth /usr/local/bin/bootnode /usr/local/bin/

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories \
    && apk add --update bash \
    && rm -rf /var/cache/apk/* 

COPY ethereum/ /usr/local/ethereum/

EXPOSE 8545 8546 30303 30303/udp
ENTRYPOINT ["/usr/local/ethereum/bootstrap.sh"]
