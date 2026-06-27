#!/system/bin/sh
MODDIR=${0%/*}
pid=$(ps -ef | grep $1 | grep -v grep | cut -d "Seto_charge.sh" -f 2)
file1=/data/adb/modules/SetoSkins/配置.prop
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null |tr -d '\n')
file3=$(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/fast_charge_current /sys/class/power_supply/*/thermal_input_current 2>/dev/null |tr -d ' ')
show_value() {
	local value=$1
	local file=/data/adb/modules/SetoSkins/配置.prop
	grep "$value" "$file" | cut -d "=" -f2
}
log=$MODDIR/limit.log
logc=0
getp() {
	temp=$(($(cat /sys/class/power_supply/battery/temp) / 10))
	a=$(grep "一限温度阈值" "$file1" | cut -d "=" -f2)
	b=$(grep "一限限制电流" "$file1" | cut -d "=" -f2)
	a1=$(grep "二限温度阈值" "$file1" | cut -d "=" -f2)
	b1=$(grep "二限限制电流" "$file1" | cut -d "=" -f2)
	a2=$(grep "三限温度阈值" "$file1" | cut -d "=" -f2)
	b2=$(grep "三限限制电流" "$file1" | cut -d "=" -f2)
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
				echo "$b" >"$file3"
					echo "$b" >/sys/class/power_supply/battery/constant_charge_current_max
			echo "触发一限温度阈值 temp:$a current:$b" | tee -a $log
			kill -19 $pid
		elif
			[[ $temp -lt $a ]]
		then
			echo "50000000" >"$file2"
			echo "50000000" >"$file3"
					echo "50000000" >/sys/class/power_supply/battery/constant_charge_current_max
			kill -18 $pid
			echo "触发无限制阈值 temp:$a" | tee -a $log
		elif [[ $temp -gt $a1 ]]; then
			echo "$b1" >"$file2"
			echo "$b1" >"$file3"
					echo "$b1" >/sys/class/power_supply/battery/constant_charge_current_max
			kill -19 $pid
			echo "触发二限温度阈值 temp:$a1 current:$b1" | tee -a $log
		elif [[ $temp -gt $a2 ]]; then
			echo "$b2" >"$file2"
				echo "$b2" >"$file3"
					echo "$b1" >/sys/class/power_supply/battery/constant_charge_current_max
			kill -19 $pid
			echo "触发三限温度阈值 temp:$a2 current:$b2" | tee -a $log
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
			echo "50000000" >"$file3"
					echo "50000000" >/sys/class/power_supply/battery/constant_charge_current_max
			sleep 10
		elif [[ $capacity -ge $f ]]; then
			echo "$f1" >"$file2"
			echo "$f1" >"$file3"
					echo "$f1" >/sys/class/power_supply/battery/constant_charge_current_max
			echo "触发三限电量阈值 current:$f" | tee -a $log
		elif [[ $capacity -ge $e ]]; then
			echo "$e1" >"$file2"
			echo "$e1" >"$file3"
					echo "$e1" >/sys/class/power_supply/battery/constant_charge_current_max
			echo "触发二限电量阈值 current:$e" | tee -a $log
		elif [[ $capacity -ge $d ]]; then
			echo "$d1" >"$file2"
			echo "$d1" >"$file3"
					echo "$d1" >/sys/class/power_supply/battery/constant_charge_current_max
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
			echo "$g" >"$file3"
					echo "$g" >/sys/class/power_supply/battery/constant_charge_current_max
			echo $(date) "亮屏充电 限制电流：$g" | tee -a $log
		elif [[ $status == "Charging" ]] || [[ $Bright == "mIsScreenOn=false" ]]; then
			echo "$g1" >"$file3"
			echo "$g1" >"$file2"
					echo "$g1" >/sys/class/power_supply/battery/constant_charge_current_max
			echo $(date) "息屏充电 限制电流：$g1" | tee -a $log
		fi
	done
fi