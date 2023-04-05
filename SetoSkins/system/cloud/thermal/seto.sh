  if [[ "$(getprop sys.boot_completed)" == "1" ]];then
sleep 1
fi
  for i in `seq 72`;
do
sleep 1
 cp /data/media/0/Android/备份温控（请勿删除）/* /data/vendor/thermal/config/
done
exit 1