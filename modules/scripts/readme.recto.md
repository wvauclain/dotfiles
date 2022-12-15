# Tmux

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



## General Settings

### Prefix Key
I find `C-a` so much easier to type than `C-b`, so I reset the prefix key to
match the prefix key for `screen`:
```tmux file="@?prefix-key.file"
@@prefix-key
```

### Unbinding Keys

By default, tmux comes with a lot of keybindings. I found this to be a little
bit overwhelming when I started using tmux, so my solution was to wipe all of
the default keybindings and then bring back only the ones that I need:
```tmux file="@?unbind-keys.file"
@@unbind-keys
```

### History Limit

Tmux's history limit makes sense for computers with small amounts of RAM, but
it easily gets blown through when you have a command that outputs lots of lines
of data. Since I have gigabytes of RAM, I upped the history limit to 32k lines:
```tmux file="@?history-limit.file"
@@history-limit
```
This still gets blown through by some commands, like when I add logging to
something like my Verilog processor for CIS 471, but in general I think this is
a sensible tradeoff.

### Make vim Useable in Tmux

When I first started using tmux, it really messed with my vim color scheme. I
found that adding this incantation to the tmux config makes vim properly
display colors:
```tmux file="@?vim-usability.file"
@@vim-usability
```
Your mileage may vary though.

## Everything else

TODO
