#!/bin/bash
NETWORK_DEVICE="wlp4s0"
printf " " && nmcli connection show | grep wlp4s0 | grep vpn | sed -e "s/\s/_/g" -e "s/__/ /g" | awk '{print $1}' | sed "s/_/ /g"
