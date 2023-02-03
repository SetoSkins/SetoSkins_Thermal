#!/system/bin/sh
MODDIR=${0%/*}
alias sh='/system/bin/sh'
var_device=$(getprop ro.product.device)
status=$(cat /sys/class/power_supply/battery/status)
capacity=$(cat /sys/class/power_supply/battery/capacity)
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
a=$(getprop ro.system.build.version.release)
mv "$MODDIR"/作者QQ捐赠发电反馈用.jpg /data/adb/modules/SetoSkins/
mv $MODDIR/跳电请执行 /data/adb/modules/SetoSkins/
  file1=/data/adb/modules/SetoSkins/配置.prop
show_value() {
	value=$1
	file=/data/adb/modules/SetoSkins/配置.prop
	cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
if [ ! -f "/data/vendor/thermal/config/thermal-engine.comf" ];then
rm -rf /data/vendor/thermal/config/*
fi
if test $(show_value '温控配置') == 不保留; then
    mkdir -p $MODDIR/vendor/etc
	chattr -R -i -a /data/vendor/thermal/
	rm -rf "$MODDIR"/vendor/etc/*
	rm -rf /data/vendor/thermal/config/*
	#云端
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-video.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc//thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-video.conf"
	chmod 777 /sys/class/thermal/thermal_message/sconfig
	if [[ $var_device == "xagapro" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-nolimits.conf.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-video.conf"
	fi
	if [[ $var_device == "star" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf"
	fi
		if [[ $var_device == "mars" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf"
	fi
elif
	test $(show_value '温控配置') == 保留
then
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
	mkdir -p $MODDIR/vendor/etc
	rm -rf "$MODDIR"/vendor/etc/*
	rm -rf /data/vendor/thermal/config/*
	chattr -R -i -a /data/vendor/thermal/
	#云端
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-video.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc//thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-video.conf"

	if [[ $var_device == "xagapro" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-video.conf.conf"
	fi
	if [[ $var_device == "star" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf.conf"
	fi
		if [[ $var_device == "mars" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf.conf"
	fi
	chmod 777 /sys/class/thermal/thermal_message/sconfig
fi
if test $(show_value '游戏温控') == true; then
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
 if [[ $var_device == "mars" ]]; then
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
 fi
  if [[ $var_device == "star" ]]; then
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
  fi
   if [[ $var_device == "xagapro" ]]; then
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/tthermal-mgame.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
cp "$MODDIR/cloud/thermal/thermal-magame.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
   fi
fi
if test $(show_value '关闭录制4K温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-4k.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-4k.conf"
	elif
	test $(show_value '关闭录制4K温控') == false
	then
	rm -rf /data/vendor/thermal/config/thermal-4k.conf
	rm -rf $MODDIR/vendor/etc/thermal-4k.conf
fi

if test $(show_value '关闭相机温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-camera.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-camera.conf"
	elif
	
	test $(show_value '关闭相机温控') == false
	then
	rm -rf /data/vendor/thermal/config/thermal-camera.conf
	rm -rf $MODDIR/vendor/etc/thermal-camera.conf
fi

if test $(show_value '开启修改电流数') == true; then
	b=$(grep "最大电流数" "$file1" | cut -c7-)
if [ -f "/sys/class/power_supply/battery/constant_charge_current" ]; then
echo "文件存在"
 elif
  [ -f /sys/devices/platform/battery/power_supply/battery/fast_charge_current ]; then
  echo "文件存在"
   elif
   [ -f /sys/devices/platform/mt_charger/power_supply/usb/current_max ]; then
  echo "文件存在"
   elif
   [ -f /sys/devices/platform/battery/power_supply/battery/thermal_input_current ]; then
  echo "文件存在"
   elif
  [ -f /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max ]; then
  echo "文件存在"
   elif
   [ -f /sys/class/power_supply/usb/current_max ]; then
  echo "文件存在"
  else
echo -e "你的机型不支持修改最大电流数 请反馈给Seto">>/data/adb/modules/SetoSkins/log.log
  fi
	  echo "$b" > /sys/class/power_supply/battery/constant_charge_current
      echo "$b" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$b" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$b" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$b" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "$b" > /sys/firmware/devicetree/base/charger/current_max
	  fi
	
	if test $(show_value '开启修改电流数') == false; then
	  echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "50000000" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "50000000" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "50000000" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "50000000" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "50000000" > /sys/firmware/devicetree/base/charger/current_max
	fi
if test $(show_value '全局高刷（和dfps冲突）') == true; then
{
	until [[ "$(getprop sys.boot_completed)" == "1" ]]; 
	do
		sleep 1
	done
sh $MODDIR/Seto_shadow3.sh
}&
fi

if test $(show_value '关闭millet') == true; then
	cp "$MODDIR/cloud/post-fs-data.sh" "/data/adb/modules/SetoSkins/post-fs-data.sh"
elif
	test $(show_value '关闭millet') == false
then
		rm -rf /data/adb/modules/SetoSkins/post-fs-data.sh
		fi
		
if test $(show_value '关闭锁游戏分辨率（记得游戏加速选高质量）') == true; then
rm -rf /data/system/mcd
touch /data/system/mcd
chmod 444 /data/system/mcd
chattr +i /data/system/mcd
fi
if test $(show_value '修复nfc') == true; then
	mkdir -p $MODDIR/product
cp -r /product/pangu/system/* $MODDIR/product/
	elif
	test $(show_value '修复nfc') == false; then
	rm -rf $MODDIR/product
	fi
	if test $(show_value '关闭logd') == true; then
	cp -r $MODDIR/cloud/files/* $MODDIR
	elif
	test $(show_value '关闭logd') == false; then
	rm -rf $MODDIR/bin
		rm -rf $MODDIR/etc
		rm -rf $MODDIR/vendor
			rm -rf $MODDIR/Seto_logd.sh
			fi
			if test $(show_value '关闭miui更新') == true; then
	cp "$MODDIR/cloud/system.prop" "/data/adb/modules/SetoSkins/system.prop"
elif
	test $(show_value '关闭miui更新') == false
then
		rm -rf /data/adb/modules/SetoSkins/system.prop
		fi
	
if test $(show_value '开启充电调速') == true; then
sh $MODDIR/Seto_temp_threshold.sh
fi
	
	if test $(show_value '温控空文件挂载') == true; then
	cp -r $MODDIR/cloud/vendor/bin $MODDIR/vendor
		cp -r $MODDIR/cloud/lib64/ $MODDIR
			cp -r $MODDIR/cloud/bin/ $MODDIR
			cp -r $MODDIR/cloud/etc/ $MODDIR
elif
test $(show_value '温控空文件挂载') == false; then
rm -rf $MODDIR/bin/thermalserviced
rm -rf $MODDIR/lib64
rm -rf $MODDIR/etc/int/thermalservice.rc
rm -rf $MODDIR/vendor/bin/thermal_factory
rm -rf $MODDIR/vendor/bin/thermal-engine
rm -rf $MODDIR/init
fi
	if test $(show_value '跳电修复模式') == true; then
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
	mkdir -p $MODDIR/vendor/etc
	rm -rf "$MODDIR"/vendor/etc/*
	rm -rf /data/vendor/thermal/config/*
	chattr -R -i -a /data/vendor/thermal/
	#云端
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-video.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc//thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-video.conf"

	if [[ $var_device == "xagapro" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-video.conf.conf"
	fi
	if [[ $var_device == "star" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf.conf"
	fi
		if [[ $var_device == "mars" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf.conf"
	fi
	sh /data/adb/modules/SetoSkins/跳电请执行/root权限运行.sh
	while true; do
	sleep 10
	  pid=$(ps -ef | grep "mi_thermald" | grep -v grep | awk '{print $2}')
  a=$(kill -9 "$pid")
    if [ -n "$a" ]; then
      restart_mi_thermald() {
        killall -15 mi_thermald
        for i in $(which -a mi_thermald); do
          nohup "$i" >/dev/null 2>&1 &
        done
      }
    fi
    done
    fi