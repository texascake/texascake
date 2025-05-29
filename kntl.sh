#!/bin/bash

#set -e

cyan='\033[0;36m'
blue='\033[0;34m'
nocol='\033[0m'

echo -e "$cyan***********************************************"
echo -e "          BUILDING ROM from Devspaces CLI     "
echo -e "**********************************************$nocol"

crave clone destroy -y /crave-devspaces/losq

crave clone create --projectID 85 /crave-devspaces/losqmean

cd /crave-devspaces/losqmean

# Run inside foss.crave.io devspace, in the project fol>
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/manifests; \
repo init -u https://github.com/lineageos-q-mean/android -b lineage-17.1 --git-lfs; \
git clone --depth=1 https://github.com/Kneba/local_manifests -b lineage-17.1 .repo/local_manifests; \
# Sync the repositories
if [ -f /usr/bin/resync ]; then
/usr/bin/resync
else
/opt/crave/resync.sh
fi && \
source build/envsetup.sh; \
lunch lineage_X00TD-userdebug; \
export TZ=Asia/Jakarta; \
make installclean; \
mka bacon"
