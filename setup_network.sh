#!/bin/bash

set -e  # Останавливаем скрипт при ошибке

NET_XML="./custom_net.xml"
NET_NAME="custom_net"

# Проверка наличия файла сети
if [ ! -f "$NET_XML" ]; then
  echo "Файл сети '$NET_XML' не найден."
  exit 1
fi

echo "[+] Создание сети из $NET_XML"
virsh net-define "$NET_XML"

echo "[+] Включение автостарта сети $NET_NAME"
virsh net-autostart "$NET_NAME"

echo "[+] Запуск сети $NET_NAME"
virsh net-start "$NET_NAME"

# Добавление записей в /etc/hosts (если их ещё нет)
HOSTS_FILE="/etc/hosts"

add_host_entry() {
  local ip="$1"
  local name="$2"
  if ! grep -qE "^$ip\s+$name(\s+|$)" "$HOSTS_FILE"; then
    echo "[+] Добавление записи в /etc/hosts: $ip $name"
    echo "$ip $name" | sudo tee -a "$HOSTS_FILE" > /dev/null
  else
    echo "[=] Запись $ip $name уже существует в /etc/hosts"
  fi
}

add_host_entry "192.168.110.12" "docker_nginx.home"
add_host_entry "192.168.110.13" "docker_pgadmin_postgres.home"

echo "[✓] Всё готово."
