echo "个别浏览器可能会出现跳转QQ失败的问题"
sleep 4
am start -a 'android.intent.action.VIEW' -d 'https://qm.qq.com/cgi-bin/qm/qr?k=7YBfIK2FqbwPmaZGpqh7fqt1P_6Nrufw&noverify=0&personal_qrcode_source=3' >/dev/null 2>&1