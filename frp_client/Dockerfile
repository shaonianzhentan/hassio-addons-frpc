ARG BUILD_FROM
FROM $BUILD_FROM

# 安装依赖
RUN apk add --no-cache jq wget

# 版本号
ENV FRP_VERSION 0.61.1

# 根据架构下载 frp 二进制文件
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then FRP_ARCH="amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then FRP_ARCH="arm64"; \
    elif [ "$ARCH" = "armv7l" ]; then FRP_ARCH="arm"; \
    else FRP_ARCH="amd64"; fi && \
    wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz && \
    tar -zxf frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz && \
    mv frp_${FRP_VERSION}_linux_${FRP_ARCH}/frpc /usr/bin/frpc && \
    rm -rf frp_${FRP_VERSION}_linux_${FRP_ARCH}*

# 脚本处理
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]