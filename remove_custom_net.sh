#!/bin/bash

set -e

NET_NAME="custom_net"
HOSTS_FILE="/etc/hosts"
TMP_HOSTS="/tmp/hosts.tmp.$$"

# Удаление сети
if virsh net-info "$NET_NAME" &>/dev/null; then
  if virsh net-info "$NET_NAME" | grep -q "Active:.*yes"; then
    echo "[−] Останавливаю сеть $NET_NAME"
    sudo virsh net-destroy "$NET_NAME"
  else
    echo "[=] Сеть $NET_NAME уже неактивна"
  fi

  echo "[−] Удаляю определение сети $NET_NAME"
  sudo virsh net-undefine "$NET_NAME"
else
  echo "[=] Сеть $NET_NAME не найдена"
fi

# Удаление записей из /etc/hosts
echo "[−] Удаляю записи из /etc/hosts"

sudo awk '!/192\.168\.110\.12\s+docker_nginx.home/ && !/192\.168\.110\.13\s+docker_pgadmin_postgres.home/' "$HOSTS_FILE" > "$TMP_HOSTS"

sudo cp "$TMP_HOSTS" "$HOSTS_FILE"
sudo rm "$TMP_HOSTS"

echo "[✓] Удаление завершено"
