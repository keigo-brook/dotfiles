#! /bin/bash

for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    ln -fsv "$HOME/dotfiles/$f" "$HOME"/"$f"
done
