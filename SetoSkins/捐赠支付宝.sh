echo "必须本机安装支付宝"
echo "如果想上捐赠名单需要备注名字"
sleep 3
am start -a 'android.intent.action.VIEW' -d 'alipayqr://platformapi/startapp?saId=10000007&qrcode=https://qr.alipay.com/fkx14762zsd4knmahhfdw12' >/dev/null 2>&1
