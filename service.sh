#! /system/bin/sh
#=====================================================================
#script to ennsure defined settings are applied
#=====================================================================
MODDIR=${0%/*}
chmod 0755 $MODDIR/bin/curl

## source config variables
source settings.conf

## set captive portal
settings put gobal captive_portal_enabled $CAPTIVE_PORTAL_ENABLED
settings put global captive_portal_http_url $CAPTIVE_PORTTAL_HTTP
settings put global captive_portal_https_url $CAPTIVE_PORTTAL_HTTPS

## set private dns
settings put global private_dns_mode=hostname
settings put global private_dns_specifier=$PRIVATE_DNS
