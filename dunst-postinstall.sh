mkdir -p tmp/dunstify
cd tmp/dunstify
cat > dunstify.toml <<EOF
[metadata]
package_name = "dunstify"
version = "git"
description = "A replacement for notify-send."

[files]
binaries = ["dunst/dunstify"]

[commands]
prepare = "git clone https://github.com/dunst-project/dunst.git"
build = """cd dunst
make dunstify"""
EOF

~/.wspm/bin/wspm --noconfirm install dunstify.toml
