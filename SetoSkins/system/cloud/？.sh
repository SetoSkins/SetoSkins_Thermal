if [ -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ]; then
	rm -rf $MODDIR/配置.prop
	rm -rf $MODDIR/黑名单.prop
	cp /data/media/0/Android/备份温控（请勿删除）/配置.prop $MODDIR/配置.prop
	cp /data/media/0/Android/备份温控（请勿删除）/黑名单.prop $MODDIR/黑名单.prop
	rm -rf /data/media/0/Android/备份温控（请勿删除）/配置.prop
	rm -rf /data/media/0/Android/备份温控（请勿删除）/黑名单.prop
	rm -rf $MODDIR/system/cloud/？.sh
fi
