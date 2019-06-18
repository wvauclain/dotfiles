if [ "$1" = "apt" ]; then
    mkdir -p tmp/polybar
    cd tmp/polybar
    cat > polybar.toml <<EOF
[metadata]
package_name = "polybar"
version = "3.3.1"
description = "A fast and easy-to-use tool for creating status bars."

[files]
binaries = ["polybar/build/bin/polybar", "polybar/build/bin/polybar-msg"]

[commands]
prepare = """
wget https://github.com/jaagr/polybar/releases/download/3.3.1/polybar-3.3.1.tar
tar xf polybar-3.3.1.tar"""
build = """
mkdir polybar/build
cd polybar/build
cmake ..
make -j$(nproc)"""
EOF

    ~/.wspm/bin/wspm --noconfirm install polybar.toml
elif [ "$1" = "pacman" ]; then
    trizen -S polybar
fi
