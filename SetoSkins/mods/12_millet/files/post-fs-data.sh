#!/system/bin/sh
MODDIR=${0%/*}
resetprop -n persist.sys.gz.enable false
resetprop -n persist.sys.brightmillet.enable false
resetprop -n persist.sys.powmillet.enable false
resetprop -n persist.sys.millet.newversion false
