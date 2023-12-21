chattr -i /data/vendor/thermal/config
chattr -i /data/vendor/thermal/config/*
chmod 777 /data/vendor/thermal/config
chattr -R -i -a /data/adb/modules/SetoSkins/
echo 0 >/sys/class/power_supply/battery/input_suspend
rm -rf /data/adb/post-fs-data.d/post-fs-data.sh
echo '0' >/sys/class/qcom-battery/thermal_remove
echo "50000000" >/sys/class/power_supply/battery/constant_charge_current
echo "50000000" >/sys/devices/platform/battery/power_supply/battery/fast_charge_current
echo "50000000" >/sys/devices/platform/battery/power_supply/battery/thermal_input_current
echo "50000000" >/sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
echo "50000000" >/sys/devices/platform/mt_charger/power_supply/usb/current_max
echo "50000000" >/sys/firmware/devicetree/base/charger/current_max
echo "50000000" >/sys/class/power_supply/battery/constant_charge_current_max
echo "50000000" >/sys/class/power_supply/battery/fast_charge_current
echo "50000000" >/sys/class/power_supply/battery/current_max
rm -rf /data/adb/magisk/Delta.prop
function restart_mi_thermald() {
	pkill -9 -f mi_thermald
pkill -9 -f thermal-engine
for i in $(which -a thermal-engine)
do
nohup "$i" >/dev/null 2>&1 &
done
for i in $(which -a mi_thermald)
do
nohup "$i" >/dev/null 2>&1 &
done
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
}
function mk_thermal_folder() {
	resetprop -p sys.thermal.data.path /data/vendor/thermal/
	resetprop -p vendor.sys.thermal.data.path /data/vendor/thermal/

	chattr -R -i -a '/data/vendor/thermal'
	rm -rf '/data/vendor/thermal'
	mkdir -p '/data/vendor/thermal/config'
	chmod -R 0771 '/data/vendor/thermal'
	chown -R root:system '/data/vendor/thermal'
	chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'

}
if [ ! -f /data/vendor/thermal/decrypt.txt ];then
mk_thermal_folder
restart_mi_thermald
fi
		mv /data/adb/modules/SetoSkins/system/cloud/thermal/seto.sh /data/adb/service.d/seto.sh
	mv /data/adb/modules/SetoSkins/system/cloud/thermal/seto2.sh /data/adb/service.d/seto2.sh
	mv /data/adb/modules/SetoSkins/system/cloud/thermal/seto3.sh /data/adb/service.d/seto3.sh
		rm -rf /data/vendor/thermal/config/*
	chmod -R 777 /data/adb/service.d/*
