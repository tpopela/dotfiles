#!/bin/bash
set -eufo pipefail

run_host() {
  if [ -f /run/.toolboxenv ]; then
    flatpak-spawn --host "$@"
  else
    "$@"
  fi
}

pk=6807
shell_version=$(run_host gnome-shell --version | grep -oP '[0-9]+' | head -1)
info=$(curl -sL "https://extensions.gnome.org/extension-info/?pk=${pk}&shell_version=${shell_version}")
uuid=$(echo "$info" | jq -r .uuid)
download_url=$(echo "$info" | jq -r .download_url)


if ! run_host gnome-extensions list | grep -qx "$uuid"; then
  tmpfile=$(mktemp --suffix=.zip -p "$HOME")
  curl -sfL "https://extensions.gnome.org${download_url}" -o "$tmpfile"
  run_host gnome-extensions install --force "$tmpfile"
  rm "$tmpfile"
fi
