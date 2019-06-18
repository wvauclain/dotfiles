( PATH="$PATH:~/.wspm/bin/" which st > /dev/null && ! $UPDATE ) && exit 0

mkdir -p ~/suckless/
cd ~/suckless/
[ -e st ] && rm -rf st
git clone https://github.com/wvauclain/st.git
cd st
git remote set-url origin git@github.com:wvauclain/st.git
~/.wspm/bin/wspm --noconfirm install .
