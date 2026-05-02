#! /system/bin/sh
MODDIR=${0%/*}
echo "Applying values..."
su -c sh $MODDIR/service.sh
echo "Installing or Updating Webview(s)..."
source settings.conf
if [[ "${#WEBVIEW[@]}" == 3 ]]; then
  [ -f "$MODDIR/common/install.sh" ] && . "$MODDIR/common/install.sh" "all"
else
  for i in "${arr[WEBVIEW]}"; do
    [ -f "$MODDIR/common/install.sh" ] && . "$MODDIR/common/install.sh" "$i"
  done
fi
