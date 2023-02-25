#!/system/bin/sh
c=$(dumpsys window policy | grep mIsScreen|tr -d " "|sed -n '1p')
until [[ "$c" == "mIsScreenOn=true" ]]
 do
sleep 30
done
rm -rf /data/adb/service.d/seto.sh
rm -rf /data/adb/service.d/seto2.sh
rm -rf /data/media/0/Android/备份温控（请勿删除）