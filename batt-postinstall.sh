mkdir -p ~/suckless/
cd ~/suckless/
[ -e batt ] && rm -r batt
git clone https://github.com/wvauclain/batt.git
cd batt
~/.wspm/bin/wspm --noconfirm install .
