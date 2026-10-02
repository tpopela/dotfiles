#!/bin/sh

packages="
git-delta \
htop \
mc \
tig \
tmux \
jq \
vim-enhanced"

sudo dnf remove -y vim-minimal || exit 1
sudo dnf install -y $packages || exit 1
