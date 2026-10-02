#!/bin/bash
set -eufo pipefail

run_host() {
  if [ -f /run/.toolboxenv ]; then
    flatpak-spawn --host "$@"
  else
    "$@"
  fi
}

# Create the default container - will be needed to call vim as vim is not part
# of Silverblue's base image, only vi is.
if ! run_host toolbox list --containers | grep -qw ujo; then
  run_host toolbox create --yes ujo
  run_host toolbox run --container ujo setup-generic-toolbx.sh
  run_host toolbox run --container ujo vim +PluginInstall +qall
fi
