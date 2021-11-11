FROM library/alpine3.11

MAINTAINER harrywu0913 <1248120122@qq.com>

# https://github.com/krallin/tini/releases
COPY tini-muslc-amd64 /sbin/tini

# Download, build and install coscmd
RUN set -x \
    # && apk update \
    # && apk add --no-cache \
    # tini \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.11/main/" > /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
    coreutils \
    tzdata \
    bash

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["crond", "-f", "-L", "/dev/stdout"]