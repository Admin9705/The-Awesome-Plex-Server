#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
menu=$(cat /pg/var/final.choice)

if [ "$menu" == "2" ]; then
  echo ""
  echo "-----------------------------------------------------"
  echo "SYSTEM MESSAGE: Installing - Please Standby!"
  echo "-----------------------------------------------------"
  echo ""
  echo "NOTE: Install Time: 2 to 4 Minutes!"
  sleep 2
  echo ""
  wget https://git.io/vpnsetup -O vpnsetup.sh 1>/dev/null 2>&1
  sudo sh vpnsetup.sh > /pg/var/vpninfo.raw
  cat /pg/var/vpninfo.raw | tail -n -12 | head -n +4 > /pg/var/vpn.info
  rm -rf /pg/var/vpninfo.raw
  echo
  echo "-----------------------------------------------------"
  echo "SYSTEM MESSAGE: Please Copy Your Information"
  echo "-----------------------------------------------------"
  echo ""
  cat /pg/var/vpn.info
  echo ""
  echo "Config Info: Visit http://pgvpn.pgblitz.com or WIKI"
  echo "Note: pgvpn <<< command to recall your vpn info"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  else
      echo "";# leave if statement and continue.
  fi

  if [ "$menu" == "3" ]; then
    echo "Uninstaller Not Ready!"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  fi
