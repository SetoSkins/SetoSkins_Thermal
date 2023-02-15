#!/system/bin/sh
show_value() {
  value=$1
  file=/data/adb/modules/SetoSkins/配置.prop
  cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
function status() {
	dumpsys battery | grep 'status' | grep -Eo "[0-9]"
}
if test $(show_value '快充模式') == true; then
while :; do
a=$(find /sys/devices/ -type f -iname "*constant_charge_current_max*" |sed '/hardware/d'|sed -n '1p')
b=$(find /sys/devices/ -type f -iname "*constant_charge_current_max*" |sed '/hardware/d'|sed -n '2p')
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
	  echo '180' > /sys/class/power_supply/bms/temp
	  echo "50000000" > "$a"
	    echo "50000000" > "$b"
		sleep 1s
elif
 [[ "$status1" == "Discharging" ]]; then
	  echo '0' > /sys/class/power_supply/bms/temp
		sleep 30s
	fi
done
fi
