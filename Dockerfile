FROM quay.io/prometheus/busybox-linux-amd64:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com> and SRE-TM"

ARG ARCH="amd64"
ARG OS="linux"
ARG VERSION="0.20.0"

EXPOSE 9115

RUN wget -O blackbox_exporter-${VERSION}.$OS-${ARCH}.tar.gz https://github.com/prometheus/blackbox_exporter/releases/download/v${VERSION}/blackbox_exporter-${VERSION}.$OS-${ARCH}.tar.gz \
  && tar -xzf blackbox_exporter-${VERSION}.$OS-${ARCH}.tar.gz \
  && rm blackbox_exporter-${VERSION}.$OS-${ARCH}.tar.gz \
  && mv blackbox_exporter-${VERSION}.$OS-${ARCH}/blackbox_exporter /bin/blackbox_exporter \
  && chmod 700 /bin/blackbox_exporter \
  && rm -rf blackbox_exporter-${VERSION}.$OS-${ARCH}

COPY blackbox.yml /etc/blackbox_exporter/config.yml

ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/etc/blackbox_exporter/config.yml" ]
