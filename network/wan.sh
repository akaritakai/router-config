#!/bin/bash

readonly IP=/sbin/ip

configure() {
  local mod=$1
  local i=1

  while read line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    local fields=($line)
    local protocol=${fields[0]}
    local public_ip=${fields[1]}
    local netmask=${fields[2]}
    local gateway=${fields[3]}

    $IP addr $mod $public_ip/$netmask dev eth0
    $IP route $mod $gateway dev eth0 src $public_ip table $i
    $IP route $mod default via $gateway dev eth0 table $i
    $IP rule $mod from $public_ip table $i

    if (("$i" == 1)); then
      $IP route $mod $gateway dev eth0
      $IP route $mod default via $gateway dev eth0
    fi

    i=$(($i + 1))

  done < /etc/network/addresses
}

case "$1" in
  up)
    configure add
    ;;
  down)
    configure del
    ;;
  *)
    echo "Usage: $0 {up | down}"
    exit 1
esac
