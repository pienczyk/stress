# Alpine with the stress tool
FROM alpine:3.19

LABEL maintainer="pien@o2.pl" platform="linux/amd64, linux/arm/v7" email="pien@o2.pl"

ENV STRESS_VERSION=1.0.7

WORKDIR /tmp

RUN apk add --update wget g++ make && \
    wget https://github.com/resurrecting-open-source-projects/stress/releases/download/${STRESS_VERSION}/stress-${STRESS_VERSION}.tar.gz && \
    tar xvf stress-${STRESS_VERSION}.tar.gz && rm stress-${STRESS_VERSION}.tar.gz && \
    cd ./stress-${STRESS_VERSION} && \
    ./configure && make && make install && \
    apk del g++ make wget && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENTRYPOINT ["/usr/local/bin/stress"]
CMD ["--help"]
