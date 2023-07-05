#!/system/bin/sh
MODDIR=${0%/*}
pid=$(ps -ef | grep $1 | grep -v grep | cut -d "Seto_charge.sh" -f 2)
file1=/data/adb/modules/SetoSkins/配置.prop
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null|tr -d '\n')
show_value() {
	local value=$1
	local file=/data/adb/modules/SetoSkins/配置.prop
	grep "$value" "$file" | cut -d "=" -f2
}
log=/data/adb/modules/SetoSkins/limit.log
logc=0
getp() {
	temp=$(($(cat /sys/class/power_supply/battery/temp) / 10))
	a=$(grep "一限温度阈值" "$file1" | cut -d "=" -f2)
	b=$(grep "一限限制电流" "$file1" | cut -d "=" -f2)
	a1=$(grep "二限温度阈值" "$file1" | cut -d "=" -f2)
	b1=$(grep "二限限制电流" "$file1" | cut -d "=" -f2)
	c=$(grep "延迟温度阈值=" "$file1" | cut -d "=" -f2)
	d=$(grep "一限电量阈值" "$file1" | cut -d "=" -f2)
	d1=$(grep "一限电量限制电流" "$file1" | cut -d "=" -f2)
	e=$(grep "二限电量阈值" "$file1" | cut -d "=" -f2)
	e1=$(grep "二限电量限制电流" "$file1" | cut -d "=" -f2)
	f=$(grep "三限电量阈值" "$file1" | cut -d "=" -f2)
	f1=$(grep "三限电量限制电流" "$file1" | cut -d "=" -f2)
	g=$(grep "亮屏限制电流" "$file1" | cut -d "=" -f2)
	g1=$(grep "锁屏限制电流" "$file1" | cut -d "=" -f2)
}
getp
echo -n "Values:"
echo $a
echo $b
echo $a1
echo $b1
echo "$c End values"
if test $(show_value '开启充电调速') == true; then
	echo "开启充电调速"
	while true; do
		sleep 5
		getp
		let logc++
		sleep $c
		if [[ $temp -gt $a && $temp -lt $a1 ]]; then
			echo "$b" >"$file2"
			echo "触发一限温度阈值 temp:$a current:$b" | tee -a $log
			kill -19 $pid
		elif
			[[ $temp -lt $a ]]
		then
			echo "50000000" >"$file2"
			kill -18 $pid
			echo "触发无限制阈值 temp:$a" | tee -a $log
		elif [[ $temp -gt $a1 ]]; then
			echo "$b1" >"$file2"
			kill -19 $pid
			echo "触发二限温度阈值 temp:$a1 current:$b1" | tee -a $log
		fi
		[ $logc -ge 50 ] && echo -n "" >$log && logc=0
	done
fi
if test $(show_value '自定义阶梯模式') == true; then
	echo "开启自定义阶梯"
	while true; do
		sleep 10
		capacity=$(cat /sys/class/power_supply/battery/capacity)
		status=$(cat /sys/class/power_supply/battery/status)
		if [[ $status == "Discharging" ]] || [[ $status == "Full" ]]; then
			echo "50000000" >"$file2"
			sleep 10
		elif [[ $capacity -ge $f ]]; then
			echo "$f1" >"$file2"
			echo "触发三限电量阈值 current:$f" | tee -a $log
		elif [[ $capacity -ge $e ]]; then
			echo "$e1" >"$file2"
			echo "触发二限电量阈值 current:$e" | tee -a $log
		elif [[ $capacity -ge $d ]]; then
			echo "$d1" >"$file2"
			echo "触发一限电量阈值 current:$d" | tee -a $log
		fi
	done
fi

if test $(show_value '亮息屏调速') == true; then
	echo "开启亮息屏调速"
	while true; do
		Bright=$(dumpsys window policy | grep mIsScreen | tr -d " " | sed -n '1p')
		sleep 40
		if [[ $status == "Discharging" ]] || [[ $status == "Full" ]]; then
			sleep 60
		elif [[ $status == "Charging" ]] || [[ $Bright == "mIsScreenOn=true" ]]; then
			echo "$g" >"$file2"
			echo $(date) "亮屏充电 限制电流：$g" | tee -a $log
		elif [[ $status == "Charging" ]] || [[ $Bright == "mIsScreenOn=false" ]]; then
			echo "$g1" >"$file2"
			echo $(date) "息屏充电 限制电流：$g1" | tee -a $log
		fi
	done
fi
if test $(show_value '分应用调速') == true; then
	a3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '4p' | tr -cd "[0-9]")
	b3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '5p' | tr -cd "[0-9]")
	c3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '6p' | tr -cd "[0-9]")
	d3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '7p' | tr -cd "[0-9]")
	e3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '8p' | tr -cd "[0-9]")
	f3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '9p' | tr -cd "[0-9]")
	g3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '10p' | tr -cd "[0-9]")
	h3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '11p' | tr -cd "[0-9]")
	i3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '12p' | tr -cd "[0-9]")
	j3=$(cat "/data/adb/modules/SetoSkins/黑名单.prop" | sed -n '13p' | tr -cd "[0-9]")
	touch $MODDIR/检测.log
	if [ ! -f /data/adb/modules/SetoSkins/黑名单.prop ]; then
		mv /data/adb/modules/SetoSkins/system/cloud/thermal/黑名单.prop /data/adb/modules/SetoSkins/黑名单.prop
	fi
	while true; do
		sleep 30
		app=$(dumpsys activity activities | grep topResumedActivity= | tail -n 1 | cut -d "{" -f2 | cut -d "/" -f1 | cut -d " " -f3)
		if [[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "A") != "" ]]; then
			echo "$a3" >"$file2"
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "B") != "" ]]
		then
			echo "$b3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "C") != "" ]]
		then
			echo "$c3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "D") != "" ]]
		then
			echo "$d3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "E") != "" ]]
		then
			echo "$e3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "F") != "" ]]
		then
			echo "$f3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "G") != "" ]]
		then
			echo "$g3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "H") != "" ]]
		then
			echo "$h3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "I") != "" ]]
		then
			echo "$i3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		elif
			sleep 1s
			[[ $(grep "$app" "/data/adb/modules/SetoSkins/黑名单.prop" | grep "J") != "" ]]
		then
			echo "$j3" >"$file2"
			echo "应用调速开" >$MODDIR/检测.log
		else
			echo "应用调速关" >$MODDIR/检测.log
		fi
		sleep 1s
	done
fi
