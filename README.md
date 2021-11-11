
build crond on alpine:3.11 running by tini
=============================================

## build
  docker build . -f Dockerfile -t crond:3.11-alpine

## run
  docker run -it -d -v $(pwd)/crond.conf:/etc/crontabs/root --rm crond:3.11-alpine

### crond
  alpine中的crond也就是busybox中的[crond](https://github.com/mirror/busybox/blob/master/miscutils/crond.c)


  因需要root执行，则配置文件需要挂载到 /etc/crontabs/root。
  或创建其他user，挂载到对应的/etc/crontabs/${user}

### tini
  当docker stop时，即发生SIGTERM信号给PID=1的主进程，因crond本身不接受处理SIGTERM，
因此需要等到10s超时后docker kill，才会停止容器
  使用[tini](https://github.com/krallin/tini)来解决这个问题

### coreutils
  为了解决date -d等命令不同于centos，可以选择安装coreutils

### bash
  默认alpine使用 /bin/ash，可以选择安装bash
