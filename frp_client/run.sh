#!/usr/bin/with-contenv bashio

FRP_CONFIG="/tmp/frpc.toml"

# 获取配置项
SERVER_ADDR=$(bashio::config 'server_addr')
SERVER_PORT=$(bashio::config 'server_port')
TOKEN=$(bashio::config 'token')
CUSTOM_CONFIG=$(bashio::config 'custom_config')

bashio::log.info "Starting FRP Client..."

# 构建 [server] 基础配置 (TOML 格式)
cat <<EOF > $FRP_CONFIG
serverAddr = "${SERVER_ADDR}"
serverPort = ${SERVER_PORT}

auth.method = "token"
auth.token = "${TOKEN}"

EOF

# 追加用户自定义的 [[proxies]] 块
if bashio::config.has_value 'custom_config'; then
    echo "$CUSTOM_CONFIG" >> $FRP_CONFIG
    bashio::log.info "Appended custom proxy configurations."
else
    bashio::log.warning "No proxies defined in custom_config!"
fi

# 启动并传递配置
exec frpc -c $FRP_CONFIG