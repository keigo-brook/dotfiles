#! /bin/bash

for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    ln -sv "$HOME/dotfiles/$f" "$HOME"/"$f"
done
