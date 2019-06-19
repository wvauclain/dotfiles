[ ! "$1" = "xbps" ] && exit

if ! PATH="~/.wspm/bin:PATH" which ag || $UPDATE; then
    mkdir -p tmp/ag
    cd tmp/ag
    cat > the_silver_searcher.toml <<EOF
[metadata]
package_name = "the_silver_searcher"
version = "2.2.0"
description = "A code-searching tool similar to ack, but faster."

[files]
binaries = ["the_silver_searcher/ag"]

[commands]
prepare = """git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
git checkout 2.2.0"""
build = """cd the_silver_searcher
./build.sh"""
EOF

    ~/.wspm/bin/wspm --noconfirm install the_silver_searcher.toml
fi
