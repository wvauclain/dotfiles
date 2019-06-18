mkdir -p tmp/gebaar
cd tmp/gebaar
cat > gebaar.toml <<EOF
[metadata]
package_name = "gebaar"
version = "0.0.5"
description = "A Super Simple WM Independent Touchpad Gesture Daemon for libinput."

[files]
binaries = ["gebaar-libinput/build/gebaard"]

[commands]
prepare = """git clone https://github.com/Coffee2CodeNL/gebaar-libinput.git
cd gebaar-libinput
git checkout v0.0.5
git submodule update --init"""
build = """mkdir gebaar-libinput/build
cd gebaar-libinput/build
cmake ..
make -j$(nproc)"""
EOF

~/.wspm/bin/wspm --noconfirm install gebaar.toml
