#! /system/bin/sh
#===========================================================================================================
# installer for webview
#===========================================================================================================

# Extract curl depending on Architecture if not already done in an earlier run
if [[ -f "$MODPATH/bin/curl" ]]; then
  if [[ "$ARCH" = "arm" ]]; then
    unzip -j "$MODPATH/bin/curl.zip" -d "$MODPATH/bin"
  elif [[ "$ARCH" = "arm64" ]]; then
    unzip -j "$MODPATH/bin/curl64.zip" -d "$MODPATH/bin"
  else
    echo "Unsupported CPU Architecture"
    exit
  fi
  chmod 0755 $MODPATH/bin/$ARCH/curl
fi

# Alias for Curl
alias curl='$MODPATH/bin/$ARCH/curl --dns-servers 1.1.1.1,1.0.0.1'

# API Check
if [[ $API -ge 29 ]]; then
	echo "Your Android Version is Supported!"
else
	abort "Your Android Version is not Supported!"


# Check LineageOS
local LOS=$(getprop | grep -o -c "lineage")

if [[ $LOS -gt 0 ]]; then
  Install_PATH=/system/product/app
  echo "LineageOS based Custom ROM detected!"
else
  Install_PATH=/system/app
fi

mkdir -p "$MODPATH/$Install_PATH"

#Determine overay path
echo "Checking for Overlay Directory..."
if [[ $LOS -gt 0 ]]; then
	OVERLAY_PATH=system/product/overlay/
elif [[ -d /system/product/overlay ]]; then
	OVERLAY_PATH=system/product/overlay/
elif [[ -d /system_ext/overlay ]]; then
	OVERLAY_PATH=system/system_ext/overlay/
elif [[ -d /system/overlay ]]; then
	OVERLAY_PATH=system/overlay/
elif [[ -d /system/vendor/overlay ]]; then
	OVERLAY_PATH=system/vendor/overlay/
else
	abort "Unable to Find a Correct Overlay Path!"
fi
echo "Overlay Directory Found!"

echo "Creating Overlay Directory Inside the Module..."
mkdir -p "$MODPATH/$OVERLAY_PATH"


#function for installing Vanadium System WebView
install_vanadium() {

  TRI_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/16-qpr2/prebuilt/arm64/TrichromeLibrary.apk?ref_type=heads"
  WEB_URL="https://gitlab.com/grapheneos/platform_external_vanadium/-/raw/16-qpr2/prebuilt/arm64/TrichromeWebView.apk?ref_type=heads"

  #download and installation
  echo "Downloading and Installing Vanadium TrichromeLibrary..."
  curl -o "$MODPATH/$Install_PATH/VanadiumTrichromeLibrary/VanadiumTrichromeLibrary.apk" "$TRI_URL"
  if [[ -f "$MODPATH/$Install_PATH/VanadiumTrichromeLibrary/VanadiumTrichromeLibrary.apk" ]]; then
    su -c cp "$MODPATH/$Install_PATH/VanadiumTrichromeLibrary/VanadiumTrichromeLibrary.apk" /data/local/tmp
    su -c pm install --install-location 1 /data/local/tmp/VanadiumTrichromeLibrary.apk
    echo "Vanadium TrichromeLibrary installed!"
    su -c rm -f /data/local/tmp/VanadiumTrichromeLibrary.apk
  else
    abort "Couldn't Download TrichromeLibrary!"
  fi

  echo "Downloading and Installing Vanadium WebView..."
  curl -o "$MODPATH/$Install_PATH/VanadiumWebView/VanadiumWebView.apk" "$WEB_URL"
  if [[ -f "$MODPATH/$Install_PATH/VanadiumWebView/VanadiumWebView.apk" ]]; then
    su -c cp "$MODPATH/$Install_PATH/VanadiumWebView/VanadiumWebView.apk" /data/local/tmp
    su -c pm install --install-location 1 /data/local/tmp/VanadiumWebView.apk
    echo "Vanadium WebView Installed!"
    su -c rm -f /data/local/tmp/VanadiumWebView.apk
  else
    abort "Couldn't Download WebView!"
  fi
  
  #copy the overlay apk
  cp "$MODPATH/Overlay/WebViewOverlay29.apk" "$MODPATH/$OVERLAY_PATH/VanadiumWebViewOverlay.apk"
}

#function for installing AOSmium System WebView
install_aosmium() {
  local Latest32=$(curl -sS -L https://codeberg.org/AXP-OS/app_aosmium/releases/latest | grep webview32-signed.apk | grep -m 1 -o https://codeberg.org/AXP-OS/app_aosmium/releases/download/.*.apk)
  local Latest64=$(curl -sS -L https://codeberg.org/AXP-OS/app_aosmium/releases/latest | grep webview64-signed.apk | grep -m 1 -o https://codeberg.org/AXP-OS/app_aosmium/releases/download/.*.apk)
  
  # Download and Install WebView
  echo "Download and Install Aosmium WebView..."
  if [[ "$ARCH" = "arm" ]]; then
	  curl -o $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk $Latest32
	  if [[ -f $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk ]]; then
		  su -c cp $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk /data/local/tmp
		  su -c pm install --install-location 1 /data/local/tmp/AosmiumWebView.apk
		  echo "Aosmium WebView Downloaded and Installed!"
      su -c rm -f /data/local/tmp/AosmiumWebView.apk
	  else
		  abort "Couldn't Download File..."
	  fi
  elif [[ "$ARCH" = "arm64" ]]; then
	  curl -o $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk $Latest64
	  if [[ -f $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk ]]; then
		  su -c cp $MODPATH/$Install_PATH/AosmiumWebView/AosmiumWebView.apk /data/local/tmp
		  su -c pm install --install-location 1 /data/local/tmp/AosmiumWebView.apk
		  echo "Aosmium WebView Downloaded and Installed!"
      su -c rm -f /data/local/tmp/AosmiumWebView.apk
	  else
		  abort "Couldn't Download File..."
	  fi
  fi
  
  #copy the overlay apk
  cp "$MODPATH/Overlay/WebViewOverlay29.apk" "$MODPATH/$OVERLAY_PATH/AOSmiumWebViewOverlay.apk"
}

#function for installing Cromite System WebView
install_cromite() {
  if [[ "$ARCH" = "arm" ]]; then
    abort "Cromite only supports arm64 for System WebView"
  fi
  curl -sS -L https://github.com/uazo/cromite/releases/latest/download/arm64_SystemWebView.apk --output $MODPATH/$Install_PATH/webview/webview.apk
  	  if [[ -f $MODPATH/$Install_PATH/webview/webview.apk ]]; then
		  su -c cp $MODPATH/$Install_PATH/webview/webview.apk /data/local/tmp
		  su -c pm install --install-location 1 /data/local/tmp/webview.apk
		  echo "Cromite WebView downloaded and installed!"
      su -c rm -f /data/local/tmp/webview.apk
      echo "Cromite WebView is called Android System WebView in developer options!"
	  else
		  abort "Couldn't Download File..."
    fi

}

#cleanup
cleanup(){
  echo "Cleaning Up..."
  mv $MODPATH/bin/$ARCH/curl $MODPATH/bin/curl
  rm -rf $MODPATH/bin/$ARCH
  rm -rf $MODPATH/bin/*.zip
  rm -rf $MODPATH/system/.placeholder
}

# Check for positional Arguments to determine which webview(s) to install
check_args() {
  case "$1" in
  vanadium)
    install_vanadium
    ;;
  aosmium)
    install_aosmium
    ;;
  cromite)
    install_cromite
    ;;
  all) ;;
    install_aosmium
    install_vanadium
    install_cromite
  *)
    echo "No WebView passed!"
    exit 1
    ;;
  esac
}

#This is where the functions are called
for arg in "$@"; do
  check_args "$arg"
done
cleanup
