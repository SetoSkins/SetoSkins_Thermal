#!/system/bin/sh
MODDIR=${0%/*}
chattr -i /data/cache/
rm -rf /data/cache/*
chmod 000 /data/cache/
chattr -i /data/mdlog/
rm -rf /data/mdlog/*
chmod 000 /data/mdlog/
chmod 0755 /system/etc/init/mobile_log_d.rc
chmod 0755 /system/bin/logd
chmod 0755 /system/bin/mobile_log_d
chmod 0755 /system/etc/init/logd.rc
chmod 0755 /data/adb/lspd/log/
while [ 1 = 1 ]
  do
    sleep 3s
    bootd=$(getprop sys.boot_completed)
    if [[ "$bootd" == "1" ]]; then
      chmod 0000 /system/etc/init/mobile_log_d.rc
      chmod 0000 /system/bin/mobile_log_d
      chmod 0000 /system/etc/init/logd.rc
      break
    fi
  done
  
  while [ 1 = 1 ]
  do
    rm -rf /data/adb/lspd/log/ 2>/dev/null
    killall -9 mobile_log_d 2>/dev/null
    killall -9 logd 2>/dev/null
    sleep 5m
  done
  
a=1
   while true
    do
sleep 3
mkdir -p ${LSPLOG_PATH}
rm -rf /data/adb/lspd/log*
rm "${LSPLOG_PATH}/modules.log" 
rm "${LSPLOG_PATH}/all.log" 
mkdir -p ${LSP_NEW-LOG_PATH}
rm "${LSP_NEW_LOG_PATH}/modules.log" 
rm "${LSP_NEW_LOG_PATH}/all.log" 
rm "${LOG_PATH}/modules.log" 
a=$(($a+1))
echo $a
     if [[ $a>3 ]]; then
            break
        fi
done