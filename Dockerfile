FROM ethereum/client-go:v1.8.12

LABEL name="ethereum-geth-v1812" \
      author="t@tabalt.net" \
      version="1.0.0" 

ENV TZ "Asia/Shanghai"

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories
RUN apk add --update \
    bash \
  && rm -rf /var/cache/apk/* 

COPY ethereum/ /usr/local/ethereum/

ENTRYPOINT ["/usr/local/ethereum/bootstrap.sh"]

