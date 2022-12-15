# Neovim

## Configuration

The first thing that we need to do is declare which packages this file depends
on:

```ruby
@*packages.brew
```

and which variables we want to export into the ZSH environment:

```zsh
@*zprofile
```

and finally any post-install hooks:

```sh
@*postinstall
```

## Remote Package Management

The first step of installing remote vim packages is installing a plugin
manager. For historical reasons, I use `vim-plug`. I haven\'t looked at
the offerings recently enough to know if this is still good advice, but
it works for me.

```vim file="@?initialize-vim-plug.file"
@@initialize-vim-plug
```

Next, to install packages, you insert a bunch of calls to the
`Plug` function in between the following two special functions:

```vim
call plug#begin('~/.config/nvim/plugged')
" <<Package List>>
call plug#end()
```

## Tmux

`vim-tmux-navigator` is a plugin that allows the user to easily navigate
between vim splits and tmux panes using the same keybindings, at the
same time!

```vim file="@?packages/tmux.file"
@@packages/tmux
```

I don\'t really like the default keybindings, so I set my own:

```vim file="stow/.config/nvim/plugin/tmux.vim
@*stow/.config/nvim/plugin/tmux.vim
```

Another thing that annoyed me about using neovim in tmux is that I
wanted to see [which]{.underline} file I was working on, but the only
thing displayed in the tmux status bar was `1 nvim*`. To fix this, we
manually send a shell call to tmux to change the name of the terminal:

```vim file="stow/.config/nvim/plugin/tmux-title.vim
@*stow/.config/nvim/plugin/tmux-title.vim
```

## Gruvbox

I really like the gruvbox colorscheme.

```vim file="@?packages/gruvbox.file"
@@packages/gruvbox
```

```vim file="@?options/gruvbox.file"
@@options/gruvbox
```

## Rust

For some reason, neovim doesn\'t come with syntax highlighting for Rust
and TOML by default, so I install a couple of plugins to fix this:

```vim file="@?packages/rust.file"
@@packages/rust
```

## Fzf

`fzf` is a fuzzy-finder for the terminal. I use it in a couple of
different places in neovim, and it's kind of handy to have.

```vim file="@?packages/rust.file"
@@packages/fzf
```

I also have a couple extra utilities that I\'ve written using `fzf` that
are useful when you spend your whole day inside vim[^1]:

[^1]: I used to do this. Now I also use VS Code and other editors, but
    these are still useful to have around

```vim
@*stow/.config/nvim/plugin/fzf.vim
```

## Misc Utilities

I like viewing git diffs in the gutter; `vim-signify` is a really simple
plugin that makes this happen.

```vim file="@?packages/signify.file"
@@packages/signify
```

`tpope` has made lots of useful utilities that make vim behave a little
bit more intuitively.

```vim file="@?packages/tpope.file"
@@packages/tpope
```

`vim-polyglot` adds syntax files for a lot of different languages. I
don\'t remember why I originally installed it, but it\'s useful when I
go to open a filetype that I\'ve never touched before for the first
time.

```vim file="@?packages/polyglot.file"
@@packages/polyglot
```

## Status Line

A year or two I went down the rabbit hole that is custom statuslines for
vim when I was trying to decrease the number of plugins that I had
installed. Here is the result, which I\'m pretty happy with:

```vim
@*stow/.config/nvim/plugin/statusline.vim
```

## Guides

Luke Smith has a pretty elegant solution for inserting templates in
plain vimscript and then jumping around using \`\`guides\'\', which I
have stolen and incorporated into my vimrc:

```vim
@*stow/.config/nvim/plugin/guides.vim
```

## LaTeX

```vim
@*stow/.config/nvim/ftplugin/tex.vim
```

```vim
@*stow/.config/nvim/syntax/after/tex.vim
```

## Shell Scripts

```vim
@*stow/.config/nvim/ftplugin/sh.vim
```

## Misc Settings

```vim file="@?settings/misc.file"
@@settings/misc
```


