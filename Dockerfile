FROM golang:1.12.4 as lnd-builder
LABEL stage="lnd-builder"

ARG USER
ARG PASS

RUN git clone https://"${USER}:${PASS}"@github.com/xenaex/lnd.git && \
    cd lnd && \
    go get && \
    make install

# Image to use
FROM ubuntu:xenial

RUN mkdir -p /blockchain/data/chain/bitcoin/testnet /blockchain/data/chain/bitcoin/mainnet

COPY --from=lnd-builder /go/bin/lnd   /usr/local/bin/lnd
COPY --from=lnd-builder /go/bin/lncli /usr/local/bin/lncli

ENV LIGHTNING_DATA=/blockchain/

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 9735 10009 8080

CMD ["lnd"]
