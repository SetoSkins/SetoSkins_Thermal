#!/system/bin/sh
show_value() {
  value=$1
  file=/data/adb/modules/SetoSkins/配置.prop
  cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
function status() {
	dumpsys battery | grep 'status' | grep -Eo "[0-9]"
}
c=$(cat /data/adb/modules/SetoSkins/system/节点.prop |sed -n '1p')
d=$(cat /data/adb/modules/SetoSkins/system/节点.prop |sed -n '2p')
if test $(show_value '快充模式') == true; then
while :; do
status1=$(cat /sys/class/power_supply/battery/status)
 if [[ "$status" = "2" ]] || [[ "$status1" == "Charging" ]]; then
 echo "0" > /sys/class/power_supply/battery/step_charging_enabled
      echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "50000000" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "50000000" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "50000000" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "50000000" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "50000000" > /sys/firmware/devicetree/base/charger/current_max
	  echo "50000000" > /sys/class/power_supply/mtk-master-charger/constant_charge_current_max
	  	    echo "50000000" > /sys/class/power_supply/battery/constant_charge_current_max
	  	    echo "50000000" >/sys/class/power_supply/battery/fast_charge_current
	  	    echo "50000000" >/sys/class/power_supply/battery/current_max
	  echo '180' > /sys/class/power_supply/bms/temp
	  echo "50000000" > "$c"
	    echo "50000000" > "$d"
		sleep 1s
elif
 [[ "$status1" == "Discharging" ]]; then
	  echo '0' > /sys/class/power_supply/bms/temp
		sleep 30s
	fi
done
fi
