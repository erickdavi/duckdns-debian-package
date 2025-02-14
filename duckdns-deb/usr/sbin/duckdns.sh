#!/bin/bash

source /etc/duckdns.conf

# Verifica se as variáveis necessárias estão definidas
if [[ -z "$DOMAINS" || -z "$TOKEN" ]]; then
    echo "Erro: Variáveis DOMAINS e TOKEN devem estar definidas em /etc/duckdns.conf"
    exit 1
fi

# Decodifica o token e define a URL da requisição
TOKEN=$(echo -n "$TOKEN" | base64 -d)
URL="https://www.duckdns.org/update?domains=${DOMAINS}&token=${TOKEN}"

# Executa a requisição ao DuckDNS
PAYLOAD=$(curl -ks --max-time 10 --retry 3 "${URL}")

# Nome do serviço no syslog
LOGGER_TAG="duckdns-update"

# Registra logs no syslog
if [[ "$PAYLOAD" == "OK" ]]; then
    logger -t "$LOGGER_TAG" -p user.info "DuckDNS update successful for domain(s): $DOMAINS"
else
    logger -t "$LOGGER_TAG" -p user.error "DuckDNS update failed for domain(s): $DOMAINS. Response: $PAYLOAD"
fi
