if [ -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ];then
rm -rf /data/adb/modules/SetoSkins/配置.prop
cp /data/media/0/Android/备份温控（请勿删除）/配置.prop /data/adb/modules/SetoSkins/配置.prop
rm -rf /data/media/0/Android/备份温控（请勿删除）/配置.prop
rm -rf /data/adb/modules/SetoSkins/system/cloud/？.sh
fi