if [ -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ]; then
    rm -rf /data/adb/SetoSkins/
	rm -rf $MODDIR/配置.prop
	rm -rf $MODDIR/$MODDIR/cloud/thermal/thermal-per-huanji.conf
	rm -rf $MODDIR/无温控应用.prop          # 新增
	cp /data/media/0/Android/备份温控（请勿删除）/配置.prop $MODDIR/配置.prop
	cp /data/media/0/Android/备份温控（请勿删除）/$MODDIR/cloud/thermal/thermal-per-huanji.conf $MODDIR/$MODDIR/cloud/thermal/thermal-per-huanji.conf
	cp /data/media/0/Android/备份温控（请勿删除）/无温控应用.prop $MODDIR/无温控应用.prop  # 新增
	rm -rf /data/media/0/Android/备份温控（请勿删除）/配置.prop
	rm -rf /data/media/0/Android/备份温控（请勿删除）/$MODDIR/cloud/thermal/thermal-per-huanji.conf
	rm -rf /data/media/0/Android/备份温控（请勿删除）/无温控应用.prop  # 新增
	rm -rf $MODDIR/system/cloud/？.sh
fi
