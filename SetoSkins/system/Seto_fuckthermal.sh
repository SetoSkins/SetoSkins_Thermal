#!/system/bin/sh
MODDIR=${0%/*}

alias sh='/system/bin/sh'
var_device=$(getprop ro.product.device)
status=$(cat /sys/class/power_supply/battery/status)
capacity=$(cat /sys/class/power_supply/battery/capacity)
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
a=$(getprop ro.system.build.version.release)

# 修复：提前创建目标文件夹防止 mv 失败，并增加文件存在性判断
if [ -f "$MODDIR/执行作者主页.sh" ]; then
	mkdir -p "$MODDIR/乱七八糟"
	mv "$MODDIR/执行作者主页.sh" "$MODDIR/乱七八糟/执行作者主页.sh"
fi

file1=/data/adb/modules/SetoSkins/配置.prop
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>/dev/null | tr -d '\n')
file3=$(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/fast_charge_current /sys/class/power_supply/*/thermal_input_current 2>/dev/null |tr -d ' ')

show_value() {
	value=$1
	file=/data/adb/modules/SetoSkins/配置.prop
	if [ -f "${file}" ]; then
		cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
	else
		echo "false"
	fi
}

rm -rf /data/vendor/thermal/config/*
chattr -R -i -a /data/vendor/thermal/

# 云端逻辑开始
if test "$(show_value '均衡式性能温控')" == "false"; then
	if test "$(show_value '跳电修复模式')" == "false"; then
		if test "$(show_value '还原性能模式温控')" == "false"; then
			if test "$(show_value '还原均衡模式温控')" == "false"; then
			# 1. 自动识别静态温控文件的源路径与挂载目标路径
			if [ -f "/system/vendor/odm/etc/thermal-normal.conf" ]; then
				THERMAL_SRC="/odm/etc"
				THERMAL_DST="$MODDIR/vendor/odm/etc"
			else
				THERMAL_SRC="/vendor/etc"
				THERMAL_DST="$MODDIR/vendor/etc"
			fi
			
			# 2. 统一创建静态挂载目录并批量生成性能温控文件
			mkdir -p "$THERMAL_DST"
			for file in $THERMAL_SRC/thermal-*; do
				if [ -f "$file" ]; then
					filename=$(basename "$file")
					cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$THERMAL_DST/$filename"
				fi
			done
			
			# 3. 【彻底修复 Bug】剥离出 if-else 分支，无论何种布局，只要运行时温控目录存在就直接无差别覆盖
			if [ -d "/data/vendor/thermal/config" ]; then
				for file in $THERMAL_SRC/thermal-*; do
					if [ -f "$file" ]; then
						filename=$(basename "$file")
						cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/$filename"
					fi
				done
			fi
			
			chmod 777 /sys/class/thermal/thermal_message/sconfig

			case "$var_device" in
				xagapro) var_device_trans=l16u ;;
				star | mars) var_device_trans=k1a ;;
			esac
			
			if [[ $var_device_trans != "" ]]; then
				# 云端精准覆盖特定机型缓存
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-normal.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-class0.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-nolimits.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-tgame.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-mgame.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-video.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-video.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-normal.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-class0.conf"
				# 本地精准覆盖特定机型挂载
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-per-${var_device_trans}-normal.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-per-${var_device_trans}-class0.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-class0.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-nolimits.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-tgame.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-mgame.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-per-${var_device_trans}-video.conf"
				cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-video.conf"
			fi
		fi
	fi
fi
fi

chmod 777 /sys/class/thermal/thermal_message/sconfig

if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
	if test "$(show_value '均衡式性能温控')" == "true"; then
		rm -rf /data/vendor/thermal/config/*mgame.conf
		rm -rf $MODDIR/vendor/etc/*mgame.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-tgame.conf /data/vendor/thermal/config/thermal-mgame.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-tgame.conf $MODDIR/vendor/etc/thermal-mgame.conf
		for f in /data/media/0/Android/备份温控（请勿删除）/*tgame.conf; do [ -f "$f" ] && cp -f "$f" /data/vendor/thermal/config/; done
		for f in /data/media/0/Android/备份温控（请勿删除）/*tgame.conf; do [ -f "$f" ] && cp -f "$f" $MODDIR/vendor/etc/; done
		cp -f -f $MODDIR/cloud/thermal/thermal-per-huanji.conf $MODDIR/vendor/etc/thermal-mgame.conf
	
		if [[ $var_device_trans != "" ]]; then
			rm -rf /data/vendor/thermal/config/*mgame.conf
			rm -rf $MODDIR/vendor/etc/*mgame.conf
			cp -f -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
			cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-mgame.conf"
			cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-mgame.conf"
		fi
	fi
fi

if test "$(show_value '游戏均衡式性能温控')" == "true"; then
	rm -rf /data/vendor/thermal/config/*per.conf
	rm -rf $MODDIR/vendor/etc/*per.conf
	cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-per-normal.conf /data/vendor/thermal/config/thermal-normal.conf
	cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-per-class0.conf /data/vendor/thermal/config/thermal-class0.conf
	cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-per-normal.conf $MODDIR/vendor/etc/thermal-normal.conf
	cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-per-class0.conf $MODDIR/vendor/etc/thermal-class0.conf
	for f in /data/media/0/Android/备份温控（请勿删除）/*per.conf; do [ -f "$f" ] && cp -f "$f" /data/vendor/thermal/config/; done
	for f in /data/media/0/Android/备份温控（请勿删除）/*per.conf; do [ -f "$f" ] && cp -f "$f" $MODDIR/vendor/etc/; done
	cp -f -f $MODDIR/cloud/thermal/thermal-per-huanji.conf $MODDIR/vendor/etc/thermal-per-normal.conf
	cp -f -f $MODDIR/cloud/thermal/thermal-per-huanji.conf $MODDIR/vendor/etc/thermal-per-class0.conf
	cp -f -f $MODDIR/cloud/thermal/thermal-per-huanji.conf /data/vendor/thermal/config/thermal-per-normal.conf
	cp -f -f $MODDIR/cloud/thermal/thermal-per-huanji.conf /data/vendor/thermal/config/thermal-per-class0.conf

	if [[ $var_device_trans != "" ]]; then
		rm -rf /data/vendor/thermal/config/*normal.conf
		rm -rf /data/vendor/thermal/config/*class0.conf
		rm -rf "$MODDIR/vendor/etc/*normal.conf"
		rm -rf "$MODDIR/vendor/etc/*class0.conf"
		BACKUP_DIR="/data/media/0/Android/备份温控（请勿删除）"
		if [ -d "$BACKUP_DIR" ]; then
			for f in "$BACKUP_DIR"/*normal.conf "$BACKUP_DIR"/*class0.conf; do
				if [ -f "$f" ]; then
					cp -f "$f" /data/vendor/thermal/config/
					cp -f "$f" "$MODDIR/vendor/etc/"
				fi
			done
		fi
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/vendor/thermal/config/thermal-per-normal.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/vendor/thermal/config/thermal-per-class0.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "$MODDIR/vendor/etc/thermal-per-normal.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "$MODDIR/vendor/etc/thermal-per-class0.conf"
	fi
fi

if test "$(show_value '关闭录制温控')" == "true"; then
	if [ ! -d /data/media/0/Android/备份温控（请勿删除） ]; then
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/odm/etc/thermal-4k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/odm/etc/thermal-8k.conf"
	else
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-4k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-4k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-8k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-8k.conf"
	fi
	if [[ $var_device_trans != "" ]]; then
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-4k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-4k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-8k.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-8k.conf"
	fi
elif test "$(show_value '关闭录制温控')" == "false"; then
	rm -rf /data/vendor/thermal/config/*4k.conf
	rm -rf $MODDIR/vendor/etc/*4k.conf
	rm -rf $MODDIR/vendor/odm/etc/*4k.conf
	rm -rf $MODDIR/vendor/odm/etc/*8k.conf
	rm -rf /data/vendor/thermal/config/*8k.conf
	rm -rf $MODDIR/vendor/etc/*8k.conf
fi

if test "$(show_value '关闭相机温控')" == "true"; then
	if [ ! -d /data/media/0/Android/备份温控（请勿删除） ]; then
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/odm/etc/thermal-camera.conf"
	else
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-per-camera.conf"
	fi
	if [[ $var_device_trans != "" ]]; then
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-per-${var_device_trans}-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-camera.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-camera.conf"
	fi
elif test "$(show_value '关闭相机温控')" == "false"; then
	rm -rf /data/vendor/thermal/config/*camera.conf
	rm -rf $MODDIR/vendor/etc/*camera.conf
	rm -rf $MODDIR/vendor/odm/etc/*camera.conf
fi

function restart_mi_thermald() {
	pkill -9 -f mi_thermald
	pkill -9 -f thermal-engine
	for i in $(which -a thermal-engine); do
		nohup "$i" >/dev/null 2>&1 &
	done
	for i in $(which -a mi_thermald); do
		nohup "$i" >/dev/null 2>&1 &
	done
	killall -15 mi_thermald
	for i in $(which -a mi_thermald); do
		nohup "$i" >/dev/null 2>&1 &
	done
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
}

restart_mi_thermald

if test "$(show_value '开启修改电流数')" == "true"; then
	b=$(grep "最大电流数" "$file1" | cut -c7-)
	echo "$b" >"$file3"
	echo "$b" >"$file2"
fi

if test "$(show_value '开启修改电流数')" == "false"; then
	echo "50000000" >"$file2"
	echo "50000000" >"$file3"
fi

if test "$(show_value '全局高刷（和dfps冲突）')" == "true"; then
	{
		until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
			sleep 1
		done
		sh $MODDIR/cloud/Seto_shadow3.sh
	} &
fi

if test "$(show_value '关闭millet')" == "true"; then
	mv $MODDIR/cloud/post-fs-data.sh /data/adb/post-fs-data.d/post-fs-data.sh
elif test "$(show_value '关闭millet')" == "false"; then
	rm -rf /data/adb/post-fs-data.d/post-fs-data.sh
fi

if test "$(show_value '关闭锁游戏分辨率（记得游戏加速选高质量）')" == "true"; then
	rm -rf /data/system/mcd
	touch /data/system/mcd
	chmod 444 /data/system/mcd
	chattr +i /data/system/mcd
fi

if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
	if test "$(show_value '还原性能模式温控')" == "true"; then
		rm -rf $MODDIR/vendor/etc/*per*.conf
		rm -rf $MODDIR/vendor/etc/*tgame.conf
		rm -rf $MODDIR/vendor/etc/*yuanshen*.conf
		rm -rf $MODDIR/vendor/etc/*xingtie*.conf
		rm -rf $MODDIR/vendor/odm/etc/*per*.conf
		rm -rf $MODDIR/vendor/odm/etc/*tgame.conf
		rm -rf $MODDIR/vendor/odm/etc/*yuanshen*.conf
		rm -rf $MODDIR/vendor/odm/etc/*xingtie*.conf
		rm -rf /data/vendor/thermal/config/*per*.conf
		rm -rf /data/vendor/thermal/config/*tgame.conf
		rm -rf /data/vendor/thermal/config/*yuanshen*.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/*per*.conf /data/vendor/thermal/config/
		cp -f /data/media/0/Android/备份温控（请勿删除）/*tgame*.conf /data/vendor/thermal/config/
		cp -f /data/media/0/Android/备份温控（请勿删除）/*xingtie*.conf /data/vendor/thermal/config/
	fi
fi
if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
	if test "$(show_value '还原均衡模式温控')" == "true"; then
		rm -rf $MODDIR/vendor/etc/thermal-normal.conf
		rm -rf $MODDIR/vendor/etc/thermal-class0.conf
		rm -rf $MODDIR/vendor/etc/thermal-video.conf
		rm -rf $MODDIR/vendor/odm/etc/thermal-normal.conf
		rm -rf $MODDIR/vendor/odm/etc/thermal-class0.conf
		rm -rf $MODDIR/vendor/odm/etc/thermal-video.conf
		rm -rf /data/vendor/thermal/config/thermal-video.conf
		rm -rf /data/vendor/thermal/config/thermal-class0.conf
		rm -rf /data/vendor/thermal/config/thermal-normal.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf /data/vendor/thermal/config/
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-class0.conf /data/vendor/thermal/config/
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-video.conf /data/vendor/thermal/config/
	fi
fi
if test "$(show_value '关闭logd')" == "true"; then
	cp -f -r $MODDIR/cloud/files/* $MODDIR
	touch $MODDIR/system.prop
	printf "persist.logd.limit=OFF\npersist.logd.size=65536\npersist.logd.size.crash=1M\npersist.logd.size.radio=1M\npersist.logd.size.system=1M\nlog.tag.stats_log=OFF\nro.logd.size=64K\nro.logd.size.stats=64K" >$MODDIR/system.prop
elif test "$(show_value '关闭logd')" == "false"; then
	rm -rf $MODDIR/bin/*log*
	rm -rf $MODDIR/etc/init/*log*
	rm -rf $MODDIR/vendor/bin/tcp $MODDIR/vendor/bin/fdump
	rm -rf $MODDIR/vendor/bin/cnss_diag
	rm -rf $MODDIR/vendor/bin/log
	rm -rf $MODDIR/Seto_logd.sh
	sed -i '/log/d' $MODDIR/system.prop
fi

if test "$(show_value '加快部分游戏启动速度')" == "true"; then
	printf "debug.game.video.speed=true\ndebug.game.video.support=true\n" >$MODDIR/system.prop
elif test "$(show_value '加快部分游戏启动速度')" == "false"; then
	sed -i '/debug.game.video.speed=true/d' $MODDIR/system.prop
	sed -i '/debug.game.video.support=true/d' $MODDIR/system.prop
fi

if test "$(show_value '温控空文件挂载')" == "true"; then
	cp -f -r $MODDIR/cloud/vendor/bin/ $MODDIR/vendor/
	cp -f -r $MODDIR/cloud/system/vendor/etc/* $MODDIR/vendor/etc/
	cp -f -r $MODDIR/cloud/lib64/ $MODDIR
	cp -f -r $MODDIR/cloud/bin/ $MODDIR
	cp -f -r $MODDIR/cloud/etc/ $MODDIR
elif test "$(show_value '温控空文件挂载')" == "false"; then
	rm -rf $MODDIR/bin/thermalserviced
	rm -rf $MODDIR/lib64
	rm -rf $MODDIR/etc/init/thermalservice.rc
	rm -rf $MODDIR/vendor/etc
	rm -rf $MODDIR/vendor/bin/thermal*
	rm -rf $MODDIR/init
fi

if test "$(show_value '亮息屏调速')" == "false"; then
	rm -rf $MODDIR/黑名单.prop
fi

if test "$(show_value '跳电修复模式')" == "true"; then
	sh $MODDIR/跳电请执行/root权限运行.sh
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
	mkdir -p $MODDIR/vendor/etc
	rm -rf $MODDIR/vendor/etc/*
	chattr -R -i -a /data/vendor/thermal/
	cp -f "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp -f "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-normal.conf"

	if [[ $var_device_trans != "" ]]; then
		cp -f "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
		cp -f "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
	fi
fi

restart_mi_thermald
