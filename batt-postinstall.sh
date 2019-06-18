( PATH="$PATH:~/.wspm/bin/" which batt > /dev/null && ! $UPDATE ) && exit 0

mkdir -p ~/suckless/
cd ~/suckless/
[ -e batt ] && rm -rf batt
git clone https://github.com/wvauclain/batt.git
cd batt
git remote set-url origin git@github.com:wvauclain/batt.git
~/.wspm/bin/wspm --noconfirm install .
