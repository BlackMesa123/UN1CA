#====================================================
# FILE:         floating_feature.sh
# AUTHOR:       BlackMesa123, ImbaWind, xpirt
# DESCRIPTION:  Read and applies all the configs
#               defined in the "sff.sh" file inside
#               the target folder.
#====================================================

# shellcheck disable=SC1091

set -e

# [
SRC_DIR="$(git rev-parse --show-toplevel)"
OUT_DIR="$SRC_DIR/out"
WORK_DIR="$OUT_DIR/work_dir"

SET_CONFIG()
{
    local CONFIG="$1"
    local VALUE="$2"
    local FILE="$WORK_DIR/system/system/etc/floating_feature.xml"

    if [[ "$2" == "-d" ]] || [[ "$2" == "--delete" ]]; then
        CONFIG="$(echo -n "$CONFIG" | sed 's/=//g')"
        if grep -Fq "$CONFIG" "$FILE"; then
            echo "Deleting \"$CONFIG\" config in /system/system/etc/floating_feature.xml"
            sed -i "/$CONFIG/d" "$FILE"
        fi
    else
        if grep -Fq "<$CONFIG>" "$FILE"; then
            echo "Replacing \"$CONFIG\" config with \"$VALUE\" in /system/system/etc/floating_feature.xml"
            sed -i "$(sed -n "/<${CONFIG}>/=" "$FILE") c\ \ \ \ <${CONFIG}>${VALUE}</${CONFIG}>" "$FILE"
        else
            echo "Adding \"$CONFIG\" config with \"$VALUE\" in /system/system/etc/floating_feature.xml"
            sed -i "/<\/SecFloatingFeatureSet>/d" "$FILE"
            if ! grep -q "Added by unica" "$FILE"; then
                echo "    <!-- Added by unica/patches/floating_feature.sh -->" >> "$FILE"
            fi
            echo "    <${CONFIG}>${VALUE}</${CONFIG}>" >> "$FILE"
            echo "</SecFloatingFeatureSet>" >> "$FILE"
        fi
    fi
}

READ_AND_APPLY_CONFIGS()
{
    local CONFIG_FILE="$SRC_DIR/target/$TARGET_CODENAME/sff.sh"

    if [ -f "$CONFIG_FILE" ]; then
        while read -r i; do
            [[ "$i" = "#"* ]] && continue
            [[ -z "$i" ]] && continue

            if [[ "$i" == *"delete" ]] || [[ -z "$(echo -n "$i" | cut -d "=" -f 2)" ]]; then
                SET_CONFIG "$(echo -n "$i" | cut -d " " -f 1)" --delete
            elif echo -n "$i" | grep -q "="; then
                SET_CONFIG "$(echo -n "$i" | cut -d "=" -f 1)" "$(echo -n "$i" | cut -d "=" -f2-)"
            else
                echo "Malformed string in target/$TARGET_CODENAME/sff.sh: \"$i\""
                return 1
            fi
        done < "$CONFIG_FILE"
    fi
}

source "$OUT_DIR/config.sh"
# ]

READ_AND_APPLY_CONFIGS

exit 0