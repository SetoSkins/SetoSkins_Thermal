#!/system/bin/sh
# One-shot late boot. Do not start polling or override app/idle FPS policies.
MODDIR=${0%/*}
STATUS="$MODDIR/boot-status.txt"
RESULT="$MODDIR/framework-status.txt"
PROP="$MODDIR/module.prop"
target=$(sed -n 's/^thermal_fps_target=//p' "$MODDIR/compatibility.txt" | head -n 1)
case "$target" in
  ''|*[!0-9]*) target='未知';;
esac
refresh_ui() {
  value=$1
  # Status text itself contains '|'. Using a sed substitution with '|' as
  # delimiter silently failed on device, leaving "waiting for reboot".
  # Use an awk field rewrite so punctuation remains literal.
  tmp="$MODDIR/.moduleprop.$$"
  if awk -v desc="$value" '
      /^description=/ { print "description=" desc; found=1; next }
      { print }
      END { if (!found) print "description=" desc }
    ' "$PROP" > "$tmp" && [ -s "$tmp" ]; then
    if ! cat "$tmp" > "$PROP"; then
      echo 'WARN: unable to update Magisk module status' >> "$RESULT"
    fi
  else
    echo 'WARN: unable to prepare Magisk module status' >> "$RESULT"
  fi
  rm -f "$tmp"
}
sh "$MODDIR/post-mount.sh"
boot=$(cat "$STATUS" 2>/dev/null)
case "$boot" in
  MOUNTED:*) level='已生效'; detail="热控映射: ${target}Hz";;
  FRAMEWORK_ONLY:*) level='部分生效'; detail='热控映射: 不适用';;
  *) printf '%s\n' "${boot:-UNSUPPORTED: no interface}" > "$RESULT"
     refresh_ui '状态: 未生效 | 请点击操作查看兼容性诊断'
     exit 0;;
esac
case "$boot" in
  *'PowerKeeper property gated'*) ;;
  *) echo 'PARTIAL: XML supported, framework thermal property unavailable' > "$RESULT"
     refresh_ui "状态: 部分生效 | $detail | 系统限制: 未确认"; exit 0 ;;
esac
attempt=0
while [ "$attempt" -lt 20 ]; do
  attempt=$((attempt+1))
  if [ "$(getprop sys.boot_completed)" = 1 ]; then
    cur=$(settings get system thermal_limit_refresh_rate 2>&1)
    case "$cur" in
      0|null)
        echo 'READY: framework thermal FPS cap cleared/unset' > "$RESULT"
        refresh_ui "状态: $level | $detail | 系统限制: 已处理"
        exit 0;;
      ''|*'Failure'*|*'Exception'*|*'transaction'*) ;;
      *)
        case "$cur" in *[!0-9]*) ;; *)
          if settings put system thermal_limit_refresh_rate 0 >/dev/null 2>&1 &&
             [ "$(settings get system thermal_limit_refresh_rate 2>/dev/null)" = 0 ]; then
            echo 'CLEARED: framework thermal FPS cap reset to zero' > "$RESULT"
            refresh_ui "状态: $level | $detail | 系统限制: 已处理"
            exit 0
          fi;; esac;;
    esac
  fi
  sleep 2
done
echo 'PARTIAL: SettingsProvider not ready or FPS cap not cleared' > "$RESULT"
refresh_ui "状态: 部分生效 | $detail | 系统限制: 未确认"
exit 0
