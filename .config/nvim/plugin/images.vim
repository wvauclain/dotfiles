com! -nargs=1 Img r! find %:p:h -maxdepth <args> -type f -exec file --mime-type {} \+ | awk -F: '$2 ~ /image\//{print $1}' | xargs sxiv -qto 2>/dev/null
