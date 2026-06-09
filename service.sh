#! /system/bin/sh
#=====================================================================
#script to ennsure defined settings are applied
#=====================================================================
chmod 0755 bin/curl

## source config variables
source settings.conf

## set captive portal
su -c settings put global cpative_portal_mode $CAPTIVE_PORTAL_ENABLED
su -c settings put global captive_portal_http_url $CAPTIVE_PORTAL_HTTP
su -c settings put global captive_portal_https_url $CAPTIVE_PORTAL_HTTPS

## set private dns
su -c settings put global private_dns_mode hostname
su -c settings put global private_dns_specifier $PRIVATE_DNS

## set ntp server
su -c settings put global ntp_server $NTP_SERVER
