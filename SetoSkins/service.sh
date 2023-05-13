#!/system/bin/sh
MODDIR=${0%/*}
dq=$(cat /sys/class/power_supply/battery/charge_full)
cc=$(cat /sys/class/power_supply/battery/charge_full_design)
bfb=$(echo "$dq $cc" | awk '{printf $1/$2}')
bfb=$(echo "$bfb 100" | awk '{printf $1*$2}') || bfb="（？）"
a=$(find /sys/devices/ -type f -iname "*constant_charge_current_max*" | sed '/hardware/d' | sed -n '1p')
b=$(find /sys/devices/ -type f -iname "*constant_charge_current_max*" | sed '/hardware/d' | sed -n '2p')
echo "$b" >$MODDIR/system/节点.prop
echo "$a" >>$MODDIR/system/节点.prop
show_value() {
	value=$1
	file=$MODDIR/配置.prop
	cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
cp /data/adb/modules/SetoSkins/system/cloud/module.prop /data/adb/modules/SetoSkins/module.prop
echo 0 >/data/vendor/thermal/thermal-global-mode
echo 1 >/sys/class/power_supply/battery/battery_charging_enabled
echo Good >/sys/class/power_supply/battery/health
chattr -i /sys/class/power_supply/battery/constant_charge_current_max
chmod 777 /sys/class/power_supply/battery/constant_charge_current_max
chmod 777 /sys/class/power_supply/battery/step_charging_enabled
chmod 777 /sys/class/power_supply/battery/fast_charge_current
chmod 777 /sys/class/power_supply/battery/fast_charge_current
chmod 777 /sys/class/power_supply/battery/thermal_input_current
chmod 777 /sys/class/power_supply/battery/input_suspend
chmod 777 /sys/class/power_supply/usb/current_max
chmod 777 /sys/class/power_supply/battery/battery_charging_enabled
echo '0' >/sys/class/power_supply/battery/step_charging_enabled
echo '0' >/sys/class/power_supply/battery/input_suspend

for scripts in $MODDIR/system/*.sh; do
	nohup /system/bin/sh $scripts 2>&1 &
done

[[ -e /sys/class/power_supply/battery/cycle_count ]] && CYCLE_COUNT="$(cat /sys/class/power_supply/battery/cycle_count) 次" || CYCLE_COUNT="（？）"

if [[ -f /sys/class/power_supply/battery/charge_full ]]; then
	[[ -e /sys/class/power_supply/battery/charge_full ]] && Battery_capacity="$(expr $(cat /sys/class/power_supply/battery/charge_full) / 1000)mAh"
elif
	[[ ! -f /sys/class/power_supply/battery/charge_full ]]
then
	[[ -e /sys/class/power_supply/bms/charge_full ]] && Battery_capacity="$(expr $(cat /sys/class/power_supply/bms/charge_full) / 1000)mAh" || Battery_capacity="(?）"
fi

echo -e $(date) ""模块启动"\n"电池循环次数: $CYCLE_COUNT"\n"电池容量: $Battery_capacity"\n"当前剩余百分比： $bfb% >"$MODDIR"/log.log

if test $(show_value '当电流低于阈值执行停充') == true; then
	echo -e ""停充模式：开启 >>"$MODDIR"/log.log
fi
if test $(show_value '开启修改电流数') == true; then
	echo -e ""限制电流：开启 >>"$MODDIR"/log.log
fi
if test $(show_value '开启充电调速') == true; then
	echo -e ""温度阈值：开启 >>"$MODDIR"/log.log
fi
if test $(show_value '自定义阶梯') == true; then
	echo -e ""自定义阶梯：开启"\n" >>"$MODDIR"/log.log
fi

if test $(show_value '简洁版配置') == true; then
	mv $MODDIR/配置.prop $MODDIR/跳电请执行/
	cp -f $MODDIR/system/cloud/配置.prop $MODDIR/配置.prop
fi

if test $(show_value '功能版配置') == true; then
	mv $MODDIR/跳电请执行/配置.prop $MODDIR/配置.prop
fi

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "MIUI_Optimization" ]]; then
		chattr -i /data/adb/modules*/MIUI_Optimization*
		chmod 666 /data/adb/modules*/MIUI_Optimization*
		rm -rf /data/adb/modules*/MIUI_Optimization*
		touch /data/adb/modules*/MIUI_Optimization*
		chattr -i /data/adb/modules/MIUI_Optimization
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "chargeauto" ]]; then
		chattr -i /data/adb/modules*/chargeauto*
		chmod 666 /data/adb/modules*/chargeauto*
		rm -rf /data/adb/modules*/chargeauto*
		touch /data/adb/modules*/chargeauto*
		chattr -i /data/adb/modules/chargeauto
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "fuck_miui_thermal" ]]; then
		chattr -i /data/adb/modules*/fuck_miui_thermal*
		chmod 666 /data/adb/modules*/fuck_miui_thermal*
		rm -rf /data/adb/modules*/fuck_miui_thermal*
		touch /data/adb/modules*/fuck_miui_thermal*
		chattr -i /data/adb/modules/fuck_miui_thermal
	fi
done
for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "MIUI_Optimization" ]]; then
		chattr -i /data/adb/modules*/MIUI_Optimization*
		chmod 666 /data/adb/modules*/MIUI_Optimization*
		rm -rf /data/adb/modules*/MIUI_Optimization*
		touch /data/adb/modules*/MIUI_Optimization*
		chattr -i /data/adb/modules/MIUI_Optimization
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "chargeauto" ]]; then
		chattr -i /data/adb/modules*/chargeauto*
		chmod 666 /data/adb/modules*/chargeauto*
		rm -rf /data/adb/modules*/chargeauto*
		touch /data/adb/modules*/chargeauto*
		chattr -i /data/adb/modules/chargeauto
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "He_zheng" ]]; then
		chattr -i /data/adb/modules*/He_zheng*
		chmod 666 /data/adb/modules*/He_zheng*
		rm -rf /data/adb/modules*/He_zheng*
		touch /data/adb/modules*/He_zheng*
		chattr -i /data/adb/modules/He_zheng
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "turbo-charge" ]]; then
		chattr -i /data/adb/modules*/turbo-charge*
		chmod 666 /data/adb/modules*/turbo-charge*
		rm -rf /data/adb/modules*/turbo-charge*
		touch /data/adb/modules*/turbo-charge*
		chattr -i /data/adb/modules/turbo-charge
	fi
done
while true; do
	sleep 6
	sh /data/adb/modules/SetoSkins/system/cloud/？.sh
	rm -rf $MODDIR/配置.prop.bak
	rm -rf $MODDIR/nohup.out
	#读取配置文件和系统数据到变量
	status=$(cat /sys/class/power_supply/battery/status)
	capacity=$(cat /sys/class/power_supply/battery/capacity)
	temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
	minus=$(cat "$MODDIR"/system/minus)
	current=$(expr $(cat /sys/class/power_supply/battery/current_now) \* $minus)
	ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
	#判断目前状态
	hint="DisCharging"
	if [[ $status == "Charging" ]]; then
		hint="NormallyCharging"
		if [[ $current -lt 2000000 ]]; then
			hint="LowCurrent"
		fi
		if [[ $temp -gt 48 ]]; then
			hint="HighTemperature"
		fi
	fi
	if test $(show_value '开启游戏温控') == true; then
		cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "$MODDIR/system/vendor/etc/thermal-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "$MODDIR/system/vendor/etc/thermal-mgame.conf"
	fi
	#进行相应操作
	if [[ $capacity == "100" ]]; then
		echo $(date)" 已充满" >>"$MODDIR"/log.log
		sed -i "/^description=/c description=[ 😊已充满 温度$temp℃ 电流$ChargemA"mA" ]" "$MODDIR/module.prop"
	elif [[ $hint == "DisCharging" ]]; then
		sed -i "/^description=/c description=[ 🔋未充电 ] 多功能保姆温控 | 充电log和配置在/data/adb/modules/SetoSkins | 48度会撞内核墙强制降流 | 卸载卡第一屏比较久是因为卸载代码较多请耐心等待一会" "$MODDIR/module.prop"
		setprop ctl.restart mi_thermald
		setprop ctl.restart thermal
		echo 1 >/sys/class/thermal/thermal_message/sconfig
	elif [[ $hint == "NormallyCharging" ]]; then
		sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ] 多功能保姆温控 | 充电log和配置在/data/adb/modules/SetoSkins | 48度会撞内核墙强制降流 | 卸载卡第一屏比较久是因为卸载代码较多请耐心等待一会" "$MODDIR/module.prop"
	elif [[ $hint == "LowCurrent" ]]; then
		sed -i "/^description=/c description=[ 充电缓慢⚠️ ️电量$capacity% 温度$temp℃ 电流$ChargemA"mA" ] 多功能保姆温控 | 充电log和配置在/data/adb/modules/SetoSkins | 48度会撞内核墙强制降流 | 卸载卡第一屏比较久是因为卸载代码较多请耐心等待一会" "$MODDIR/module.prop"
		echo '0' >/sys/class/power_supply/usb/input_current_limited
	elif [[ $hint == "HighTemperature" ]]; then
		sed -i "/^description=/c description=[ 太烧了🥵 温度$temp℃ 电流$ChargemA"mA" ] 多功能保姆温控 | 充电log和配置在/data/adb/modules/SetoSkins | 48度会撞内核墙强制降流 | 卸载卡第一屏比较久是因为卸载代码较多请耐心等待一会" "$MODDIR/module.prop"
	fi
done
