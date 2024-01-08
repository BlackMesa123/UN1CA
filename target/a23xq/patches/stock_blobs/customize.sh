REMOVE_FROM_WORK_DIR()
{
    local FILE_PATH="$1"

    if [ -e "$FILE_PATH" ]; then
        local FILE
        local PARTITION
        FILE="$(echo -n "$FILE_PATH" | sed "s.$WORK_DIR/..")"
        PARTITION="$(echo -n "$FILE" | cut -d "/" -f 1)"

        echo "Debloating /$FILE"
        rm -rf "$FILE_PATH"

        FILE="$(echo -n "$FILE" | sed 's/\//\\\//g')"
        sed -i "/$FILE /d" "$WORK_DIR/configs/fs_config-$PARTITION"

        FILE="$(echo -n "$FILE" | sed 's/\./\\./g')"
        sed -i "/$FILE /d" "$WORK_DIR/configs/file_context-$PARTITION"
    fi
}

MODEL=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 1)
REGION=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 2)

echo "Fix Google Assistant"
rm -rf "$WORK_DIR/product/priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON"
rm -rf "$WORK_DIR/product/priv-app/HotwordEnrollmentXGoogleEx4HEXAGON"
sed -i "s/HotwordEnrollmentXGoogleEx4HEXAGON/HotwordEnrollmentXGoogleEx3HEXAGON/g" "$WORK_DIR/configs/file_context-product"
sed -i "s/HotwordEnrollmentXGoogleEx4HEXAGON/HotwordEnrollmentXGoogleEx3HEXAGON/g" "$WORK_DIR/configs/fs_config-product"
sed -i "s/HotwordEnrollmentOKGoogleEx4HEXAGON/HotwordEnrollmentOKGoogleEx3HEXAGON/g" "$WORK_DIR/configs/file_context-product"
sed -i "s/HotwordEnrollmentOKGoogleEx4HEXAGON/HotwordEnrollmentOKGoogleEx3HEXAGON/g" "$WORK_DIR/configs/fs_config-product"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/product/priv-app/HotwordEnrollmentOKGoogleEx3HEXAGON" "$WORK_DIR/product/priv-app"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/product/priv-app/HotwordEnrollmentXGoogleEx3HEXAGON" "$WORK_DIR/product/priv-app"

REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/etc/permissions/com.sec.feature.cover.clearcameraviewcover.xml"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/etc/permissions/com.sec.feature.cover.flip.xml"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/etc/permissions/com.sec.feature.sensorhub_level29.xml"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/etc/permissions/com.sec.feature.wirelesscharger_authentication.xml"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/etc/permissions/com.samsung.feature.aodservice_v10.xml"
echo "Add stock system features"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/etc/permissions/com.sec.feature.sensorhub_level100.xml" \
    "$WORK_DIR/system/system/etc/permissions/com.sec.feature.sensorhub_level100.xml"
echo "/system/etc/permissions/com\.sec\.feature\.sensorhub_level100\.xml u:object_r:system_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "system/etc/permissions/com.sec.feature.sensorhub_level100.xml 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"

#Remove AOD
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/etc/permissions/com.samsung.feature.clockpack_v10.xml" \
    "$WORK_DIR/system/system/etc/permissions/com.samsung.feature.clockpack_v10.xml"
echo "/system/etc/permissions/com\.samsung\.feature\.clockpack_v10\.xml u:object_r:system_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "system/etc/permissions/com.samsung.feature.clockpack_v10.xml 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/priv-app/ClockPack_v80" "$WORK_DIR/system/system/priv-app/"
echo "system/priv-app/ClockPack_v80 0 0 755 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "system/priv-app/ClockPack_v80/ClockPack_v80.apk 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
echo "/system/priv-app/ClockPack_v80 u:object_r:system_file:s0" >> "$WORK_DIR/configs/file_context-system"
echo "/system/priv-app/ClockPack_v80/ClockPack_v80\.apk u:object_r:system_file:s0" >> "$WORK_DIR/configs/file_context-system"

echo "Add HIDL face biometrics libs"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/system_ext/lib/vendor.samsung.hardware.biometrics.face@3.0.so" \
    "$WORK_DIR/system/system/system_ext/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/system_ext/lib64/vendor.samsung.hardware.biometrics.face@3.0.so" \
    "$WORK_DIR/system/system/system_ext/lib64"
if ! grep -q "face@3\.0\.so" "$WORK_DIR/configs/file_context-system"; then
    {
        echo "/system/system_ext/lib/vendor\.samsung\.hardware\.biometrics\.face@3\.0\.so u:object_r:system_lib_file:s0"
        echo "/system/system_ext/lib64/vendor\.samsung\.hardware\.biometrics\.face@3\.0\.so u:object_r:system_lib_file:s0"
    } >> "$WORK_DIR/configs/file_context-system"
fi
if ! grep -q "face@3.0.so" "$WORK_DIR/configs/fs_config-system"; then
    {
        echo "system/system_ext/lib/vendor.samsung.hardware.biometrics.face@3.0.so 0 0 644 capabilities=0x0"
        echo "system/system_ext/lib64/vendor.samsung.hardware.biometrics.face@3.0.so 0 0 644 capabilities=0x0"
    } >> "$WORK_DIR/configs/fs_config-system"
fi

echo "Add stock vintf manifest"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/etc/vintf/compatibility_matrix.device.xml" \
    "$WORK_DIR/system/system/etc/vintf/compatibility_matrix.device.xml"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/etc/vintf/manifest.xml" \
    "$WORK_DIR/system/system/etc/vintf/manifest.xml"

echo "Add stock Tlc libs"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/libtlc_payment_spay.so" \
    "$WORK_DIR/system/system/lib/libtlc_payment_spay.so"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib64/libtlc_payment_spay.so" \
    "$WORK_DIR/system/system/lib64/libtlc_payment_spay.so"

REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/lib/android.hardware.security.keymint-V3-ndk.so"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/lib/android.hardware.security.secureclock-V1-ndk.so"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/lib/libdk_native_keymint.so"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/lib/vendor.samsung.hardware.keymint-V2-ndk.so"
REMOVE_FROM_WORK_DIR "$WORK_DIR/system/system/lib64/libdk_native_keymint.so"
echo "Add stock keymaster libs"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/android.hardware.keymaster@3.0.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/android.hardware.keymaster@4.0.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/android.hardware.keymaster@4.1.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/lib_nativeJni.dk.samsung.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/libdk_native_keymaster.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/libkeymaster4_1support.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib/libkeymaster4support.so" \
    "$WORK_DIR/system/system/lib"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib64/lib_nativeJni.dk.samsung.so" \
    "$WORK_DIR/system/system/lib64"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/lib64/libdk_native_keymaster.so" \
    "$WORK_DIR/system/system/lib64"
if ! grep -q "libdk_native_keymaster" "$WORK_DIR/configs/file_context-system"; then
    {
        echo "/system/lib/android\.hardware\.keymaster@3\.0\.so u:object_r:system_lib_file:s0"
        echo "/system/lib/android\.hardware\.keymaster@4\.0\.so u:object_r:system_lib_file:s0"
        echo "/system/lib/android\.hardware\.keymaster@4\.1\.so u:object_r:system_lib_file:s0"
        echo "/system/lib/libdk_native_keymaster\.so u:object_r:system_lib_file:s0"
        echo "/system/lib/libkeymaster4_1support\.so u:object_r:system_lib_file:s0"
        echo "/system/lib/libkeymaster4support\.so u:object_r:system_lib_file:s0"
        echo "/system/lib64/libdk_native_keymaster\.so u:object_r:system_lib_file:s0"
    } >> "$WORK_DIR/configs/file_context-system"
fi
if ! grep -q "libdk_native_keymaster" "$WORK_DIR/configs/fs_config-system"; then
    {
        echo "system/lib/android.hardware.keymaster@3.0.so 0 0 644 capabilities=0x0"
        echo "system/lib/android.hardware.keymaster@4.0.so 0 0 644 capabilities=0x0"
        echo "system/lib/android.hardware.keymaster@4.1.so 0 0 644 capabilities=0x0"
        echo "system/lib/libdk_native_keymaster.so 0 0 644 capabilities=0x0"
        echo "system/lib/libkeymaster4_1support.so 0 0 644 capabilities=0x0"
        echo "system/lib/libkeymaster4support.so 0 0 644 capabilities=0x0"
        echo "system/lib64/libdk_native_keymaster.so 0 0 644 capabilities=0x0"
    } >> "$WORK_DIR/configs/fs_config-system"
fi

echo "Add stock audio policy"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/etc/stage_policy.conf" \
    "$WORK_DIR/system/system/etc/stage_policy.conf"
