#!/system/bin/sh
# Verify the metamodule branch after the root manager mounts the module tree.
MODDIR=${0%/*}
META="$MODDIR/compatibility.txt"
STATUS="$MODDIR/boot-status.txt"
boot=$(cat "$STATUS" 2>/dev/null)
case "$boot" in PREPARED:*) ;; *) exit 0;; esac
. "$MODDIR/bin/capability.sh"
get_meta() { sed -n "s/^$1=//p" "$META" | head -n 1; }
source=$(get_meta source)
expected=$(get_meta overlay_sha256)
target=$(get_meta thermal_fps_target)
suffix=${boot#*; }
case "$source" in
  /vendor/etc/display/thermallevel_to_fps.xml|/odm/etc/display/thermallevel_to_fps.xml|/product/etc/display/thermallevel_to_fps.xml) ;;
  *) echo 'FAILED: invalid managed XML source path' > "$STATUS"; exit 0;;
esac
if [ ! -e "$MODDIR/skip_mount" ] && valid_sha "$expected" &&
   valid_target_fps "$target" &&
   [ "$(sha256sum "$source" 2>/dev/null | cut -d' ' -f1)" = "$expected" ]; then
  printf '%s\n' "MOUNTED: ${target}Hz OEM XML map verified via metamodule; $suffix" > "$STATUS"
else
  if [ "$(get_meta framework_thermal_switch)" = 1 ]; then
    printf '%s\n' "FRAMEWORK_ONLY: managed XML not active; $suffix" > "$STATUS"
  else
    echo 'FAILED: managed XML not active and framework interface unavailable' > "$STATUS"
  fi
fi
exit 0
