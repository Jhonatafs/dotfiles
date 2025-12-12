#!/bin/bash

# Tenta pegar o IP
IP=$(ip route get 1 2>/dev/null | awk '{print $7; exit}')

# Se não tiver IP, está desconectado
if [ -z "$IP" ]; then
    echo '{"text": "Offline", "class": "disconnected", "tooltip": "Sem conexão"}'
    exit
fi

# Detecta Domínio (hostname -d) ou usa "Local" se vazio
DOMAIN=$(hostname -d 2>/dev/null)
[ -z "$DOMAIN" ] && DOMAIN="Local"

# Verifica se é Wifi (checa se existe interface wlan rodando)
if grep -q "up" /sys/class/net/w*/operstate 2>/dev/null; then
    SSID=$(iwgetid -r)
    # Formato: SSID.IP (ex: sereduc.192.168...)
    TEXT="$SSID.$IP"
    TOOLTIP=" Wifi: $SSID\n Domain: $DOMAIN\n IP: $IP"
    CLASS="wifi"
else
    # Formato: Domain.IP (ex: serlab.intra.10.0...)
    TEXT="$DOMAIN.$IP"
    TOOLTIP=" Ethernet\n Domain: $DOMAIN\n IP: $IP"
    CLASS="ethernet"
fi

# Saída JSON para a Waybar ler
echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\", \"class\": \"$CLASS\"}"
