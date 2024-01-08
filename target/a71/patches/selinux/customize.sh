SKIPUNZIP=1

sed -i "/hal_dsms_service/d" "$WORK_DIR/system/system/system_ext/etc/selinux/mapping/30.0.cil"
sed -i "/uwb_regulation_skip_prop/d" "$WORK_DIR/system/system/system_ext/etc/selinux/mapping/30.0.cil"
