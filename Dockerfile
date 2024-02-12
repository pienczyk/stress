# Alpine with the stress tool
FROM alpine:3.19

LABEL maintainer="pien@o2.pl" platform="linux/amd64, linux/arm/v7" email="pien@o2.pl"

WORKDIR /tmp

RUN STRESS_VERSION=$(wget -qO - https://github.com/resurrecting-open-source-projects/stress/releases/latest |grep -Eo -m 1 "Release.{0,6}" |awk '{print $2}') && \
    apk add --update wget g++ make && \
    wget https://github.com/resurrecting-open-source-projects/stress/releases/download/${STRESS_VERSION}/stress-${STRESS_VERSION}.tar.gz && \
    tar xvf stress-${STRESS_VERSION}.tar.gz && rm stress-${STRESS_VERSION}.tar.gz && \
    cd ./stress-${STRESS_VERSION} && \
    ./configure && make && make install && \
    apk del g++ make wget && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENTRYPOINT ["/usr/local/bin/stress"]
CMD ["--help"]
