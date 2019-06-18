mkdir -p ~/suckless/
cd ~/suckless/
[ -e st ] && rm -r st
git clone https://github.com/wvauclain/st.git
cd st
~/.wspm/bin/wspm --noconfirm install .
