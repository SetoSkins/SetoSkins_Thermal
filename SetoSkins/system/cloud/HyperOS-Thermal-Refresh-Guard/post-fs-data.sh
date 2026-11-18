#!/system/bin/sh
# One-shot early boot. Validate actual OEM XML and regenerate after OTA;
# never keep mounting stale content onto a changed vendor source.
MODDIR=${0%/*}
. "$MODDIR/bin/capability.sh"
META="$MODDIR/compatibility.txt"
STATUS="$MODDIR/boot-status.txt"
touch "$MODDIR/skip_mount"
for partition in vendor odm product; do
  rm -f "$MODDIR/system/$partition/etc/display/thermallevel_to_fps.xml"
done
report() { printf '%s\n' "$1" > "$STATUS"; }
get_meta() { sed -n "s/^$1=//p" "$META" | head -n 1; }
sha() { sha256sum "$1" 2>/dev/null | cut -d' ' -f1; }
[ -r "$META" ] || { report 'SKIPPED: install metadata missing'; exit 0; }
mode=$(get_meta mode)
framework=$(get_meta framework_thermal_switch)
source=$(get_meta source)
case "$mode" in
  xml)
    # Only the audited fixed candidate paths may be mounted.
    case "$source" in
      /vendor/etc/display/thermallevel_to_fps.xml|/odm/etc/display/thermallevel_to_fps.xml|/product/etc/display/thermallevel_to_fps.xml) ;;
      *) report 'SKIPPED: invalid vendor source path'; exit 0 ;;
    esac
    [ -r "$source" ] ||
      { report 'SKIPPED: XML path/mount interface unavailable'; exit 0; }
    validate_map "$source" ||
      { report 'SKIPPED: OEM XML schema changed/unknown; stock retained'; exit 0; }
    target=$(get_meta thermal_fps_target)
    origin=$(get_meta target_origin)
    case "$origin" in
      panel)
        # DisplayManager is not yet available at post-fs-data; use the
        # physically supported mode verified during installation.
        valid_target_fps "$target" ||
          { report 'SKIPPED: stored panel peak invalid'; exit 0; }
        ;;
      thermal-map-fallback|*)
        # With no verified panel mode, follow the OEM map after OTA too.
        target="$TG_MAP_MAX_FPS"
        ;;
    esac
    valid_target_fps "$target" ||
      { report 'SKIPPED: invalid FPS target'; exit 0; }
    current_sha=$(sha "$source")
    overlay="$MODDIR/private/thermallevel_to_fps.xml"
    expected=$(get_meta source_sha256)
    overlay_sha=$(get_meta overlay_sha256)
    if [ "$current_sha" != "$expected" ] || [ ! -r "$overlay" ] ||
       [ "$(sha "$overlay")" != "$overlay_sha" ]; then
      # Regenerate using this boot's OEM source, never reuse the old
      # fingerprint against an OTA-updated file.
      tmp="$MODDIR/private/.thermallevel_to_fps.new"
      generate_map "$source" "$tmp" "$target" ||
        { rm -f "$tmp"; report 'SKIPPED: new OEM XML failed generation'; exit 0; }
      chmod 0644 "$tmp"
      apply_source_context "$source" "$tmp" ||
        { rm -f "$tmp"; report 'SKIPPED: OEM XML SELinux context unsupported'; exit 0; }
      mv -f "$tmp" "$overlay"
      overlay_sha=$(sha "$overlay")
      sed -i "s/^source_sha256=.*/source_sha256=$current_sha/;s/^overlay_sha256=.*/overlay_sha256=$overlay_sha/;s/^thermal_map_entries=.*/thermal_map_entries=$TG_COUNT/;s/^thermal_fps_target=.*/thermal_fps_target=$target/;s/^thermal_map_max_fps=.*/thermal_map_max_fps=$TG_MAP_MAX_FPS/" "$META"
    fi
    # Always recheck the transformed content before touching PID1's mount.
    [ "$(grep -c '<ThermalLevelMap[[:space:]]' "$overlay" 2>/dev/null)" = "$TG_COUNT" ] &&
    [ "$(grep '<ThermalLevelMap[[:space:]]' "$overlay" | grep -c "fps=\"$target\"")" = "$TG_COUNT" ] ||
      { report 'SKIPPED: overlay failed verification'; exit 0; }
    if has_metamodule; then
      managed="$MODDIR/system$source"
      if ! mkdir -p "${managed%/*}" || ! cp -f "$overlay" "$managed" ||
         ! chmod 0644 "$managed" || ! apply_source_context "$source" "$managed"; then
        report 'FAILED: metamodule XML preparation failed'
        exit 0
      fi
      rm -f "$MODDIR/skip_mount"
      prefix="PREPARED: ${target}Hz OEM XML awaiting metamodule mounting"
    else
      if [ ! -x /system/bin/nsenter ] ||
         ! /system/bin/nsenter -t 1 -m -- /system/bin/mount --bind "$overlay" "$source"; then
        report 'FAILED: early vendor XML bind failed; stock retained'
        exit 0
      fi
      [ "$(sha "$source")" = "$overlay_sha" ] ||
        { /system/bin/nsenter -t 1 -m -- /system/bin/umount "$source" 2>/dev/null; report 'FAILED: bind verification mismatch'; exit 0; }
      prefix="MOUNTED: ${target}Hz OEM XML map active"
    fi
    ;;
  framework) prefix='FRAMEWORK_ONLY: vendor XML unavailable';;
  *) report 'UNSUPPORTED: no verified thermal FPS control interface; stock retained'; exit 0;;
esac

if [ "$framework" = 1 ] && [ -n "$(getprop ro.vendor.fps.switch.thermal)" ]; then
  if command -v resetprop >/dev/null 2>&1 &&
     resetprop ro.vendor.fps.switch.thermal false &&
     [ "$(getprop ro.vendor.fps.switch.thermal)" = false ]; then
    report "$prefix; PowerKeeper property gated"
  else
    report "$prefix; PARTIAL PowerKeeper property gate failed"
  fi
else
  report "$prefix; framework thermal FPS property unavailable"
fi
exit 0
