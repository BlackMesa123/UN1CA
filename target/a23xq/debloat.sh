#
# Copyright (C) 2024 Fede2782
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Debloat list for Galaxy A23 5G (a23xq)
# - Add entries inside the specific partition containing that file (<PARTITION>_DEBLOAT+="")
# - DO NOT add the partition name at the start of any entry (eg. "/system/dpolicy_system")
# - DO NOT add a slash at the start of any entry (eg. "/dpolicy_system")

# Overlays
SYSTEM_DEBLOAT+="
system/app/WifiRROverlayAppH2E
system/app/WifiRROverlayAppQC
system/app/WifiRROverlayAppWifiLock
"
PRODUCT_DEBLOAT+="
overlay/SoftapOverlay6GHz
overlay/SoftapOverlayOWE
"

# HDCP
SYSTEM_DEBLOAT+="
system/bin/dhkprov
system/bin/qchdcpkprov
system/etc/init/dhkprov.rc
system/lib64/vendor.samsung.hardware.security.hdcp.keyprovisioning@1.0.so
"

# GameDriver
SYSTEM_DEBLOAT+="
system/priv-app/GameDriver-SM8550
"

# AOD
SYSTEM_DEBLOAT+="
system/priv-app/AODService_v80
system/etc/permissions/privapp-permissions-com.samsung.android.app.aodservice.xml
"

# Photo Remaster, Single Take
SYSTEM_DEBLOAT+="
system/priv-app/PhotoRemasterService
system/priv-app/SumeNNService
system/priv-app/SingleTakeService
system/etc/permissions/privapp-permissions-com.samsung.android.photoremasterservice.xml
system/etc/permissions/privapp-permissions-com.samsung.android.singletake.service.xml
system/etc/default-permissions/default-permissions-com.samsung.android.singletake.service.xml
"

# Camera SDK
SYSTEM_DEBLOAT+="
system/etc/permissions/cameraservice.xml
system/framework/scamera_sep.jar
system/priv-app/SCameraSDKService
"

# Mocca
SYSTEM_DEBLOAT+="
system/app/MoccaMobile
"

# eSE
SYSTEM_DEBLOAT+="
system/app/ESEServiceAgent
system/bin/esecos_daemon
system/bin/sem_daemon
system/etc/init/esecos.rc
system/etc/init/sem.rc
system/etc/permissions/privapp-permissions-com.sec.factoryapp.xml
system/lib/libsec_sem.so
system/lib/libsec_semHal.so
system/lib/libsec_semRil.so
system/lib/libsec_semTlc.so
system/lib/libspictrl.so
system/lib/vendor.samsung.hardware.security.sem@1.0.so
system/lib64/libsec_sem.so
system/lib64/libsec_semHal.so
system/lib64/libsec_semRil.so
system/lib64/libsec_semTlc.so
system/lib64/libspictrl.so
system/lib64/vendor.samsung.hardware.security.sem@1.0.so
system/priv-app/SEMFactoryApp
"

# system_ext clean-up
SYSTEM_DEBLOAT+="
system/etc/permissions/org.carconnectivity.android.digitalkey.rangingintent.xml
system/etc/permissions/org.carconnectivity.android.digitalkey.secureelement.xml
"
SYSTEM_EXT_DEBLOAT+="
app/QCC
bin/qccsyshal@1.2-service
etc/permissions/com.qti.location.sdk.xml
etc/permissions/com.qualcomm.location.xml
etc/permissions/privapp-permissions-com.qualcomm.location.xml
framework/com.qti.location.sdk.jar
framework/org.carconnectivity.android.digitalkey.rangingintent.jar
framework/org.carconnectivity.android.digitalkey.secureelement.jar
framework/oat/arm/com.qti.location.sdk.art
framework/oat/arm/com.qti.location.sdk.odex
framework/oat/arm/com.qti.location.sdk.vdex
framework/oat/arm/org.carconnectivity.android.digitalkey.rangingintent.odex
framework/oat/arm/org.carconnectivity.android.digitalkey.rangingintent.vdex
framework/oat/arm/org.carconnectivity.android.digitalkey.secureelement.odex
framework/oat/arm/org.carconnectivity.android.digitalkey.secureelement.vdex
framework/oat/arm64/com.qti.location.sdk.art
framework/oat/arm64/com.qti.location.sdk.odex
framework/oat/arm64/com.qti.location.sdk.vdex
framework/oat/arm64/org.carconnectivity.android.digitalkey.rangingintent.odex
framework/oat/arm64/org.carconnectivity.android.digitalkey.rangingintent.vdex
framework/oat/arm64/org.carconnectivity.android.digitalkey.secureelement.odex
framework/oat/arm64/org.carconnectivity.android.digitalkey.secureelement.vdex
lib/libqcc.so
lib/libqcc_file_agent_sys.so
lib/libqccdme.so
lib/libqccfileservice.so
lib/vendor.qti.hardware.qccsyshal@1.0.so
lib/vendor.qti.hardware.qccsyshal@1.1.so
lib/vendor.qti.hardware.qccsyshal@1.2.so
lib/vendor.qti.hardware.qccvndhal@1.0.so
lib/vendor.qti.hardware.trustedui@1.1.so
lib/vendor.qti.hardware.trustedui@1.2.so
lib/vendor.qti.qccvndhal_aidl-V1-ndk.so
lib64/libqcc.so
lib64/libqcc_file_agent_sys.so
lib64/libqccdme.so
lib64/libqccfileservice.so
lib64/vendor.qti.hardware.qccsyshal@1.0.so
lib64/vendor.qti.hardware.qccsyshal@1.1.so
lib64/vendor.qti.hardware.qccsyshal@1.2-halimpl.so
lib64/vendor.qti.hardware.qccsyshal@1.2.so
lib64/vendor.qti.hardware.qccvndhal@1.0.so
lib64/vendor.qti.hardware.trustedui@1.1.so
lib64/vendor.qti.hardware.trustedui@1.2.so
lib64/vendor.qti.qccvndhal_aidl-V1-ndk.so
priv-app/com.qualcomm.location
priv-app/com.qualcomm.qti.services.systemhelper
"
