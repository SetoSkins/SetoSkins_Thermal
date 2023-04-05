#!/system/bin/sh
while true; do
if [[ "$(getprop sys.boot_completed)" == "1" ]];then
sleep 60
rm -rf /data/media/0/Android/备份温控（请勿删除）
rm -rf /data/adb/service.d/seto.sh
rm -rf /data/adb/service.d/seto2.sh
exit 0
fi
done
