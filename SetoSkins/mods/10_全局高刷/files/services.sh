#!/system/bin/sh
MODDIR=${0%/*}
until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
    sleep 1
done
settings put system min_refresh_rate 120
