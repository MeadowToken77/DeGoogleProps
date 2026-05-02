# DeGoogleProps
Magisk/KernelSU Module that changes some System settings to DeGoogle your ROM
 
 ## Features
 - installs a privacy friendly WebView implementation: you can select between Vanadium, AOSmium and Cromite System WebView
 - automatically debloats conflicting WebView packages systemlessly
 - can change your captive portal mode (choice between on/prompt/off)
 - changes your captive portal provider to a non-google-provider (default is connectivitycheck.grapheneos.network)
 - changes your Private DNS to a provider of your choice (default is adblock.dns.mullvad.net)
 - changes your NTP server to a provider of your choice (default is pool.ntp.org)

 ## Installation
 - Installation requires a stable Wifi connection to reliably be able to download the webview apks
 - Install in Magisk, KernelSU or the Module Manager of your choice

 ## Configuration
 - Configure the settings by either editing settings.conf manually in the module directory (or running action.sh WIP)

 ## Contributing
 - If you are missing a feature that is not [out of scope](out-of-scope.md), feel free to open an issue or pull request!

 ## Credits
 - NoneBaiano for VanadiumWebViewBrowser
