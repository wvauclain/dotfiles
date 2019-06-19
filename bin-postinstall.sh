# adb-sync
if ( ! PATH="$PATH:~/.wspm/bin/" which adb-sync > /dev/null || $UPDATE ); then
mkdir -p tmp/adb-sync
cd tmp/adb-sync
cat > adb-sync.toml <<EOF
[metadata]
package_name = "adb-sync"
version = "git"
description = "adb-sync is a tool to synchronize files between a PC and an Android device using the ADB (Android Debug Bridge)."

[files]
binaries = ["adb-sync/adb-sync"]

[commands]
prepare = """git clone https://github.com/google/adb-sync.git"""
build = ""
EOF

~/.wspm/bin/wspm --noconfirm install adb-sync.toml
fi
