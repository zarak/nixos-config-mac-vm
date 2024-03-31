#!/usr/bin/env bash

# Original source:
# https://gist.githubusercontent.com/0atman/1a5133b842f929ba4c1e195ee67599d5/raw/4e2f3ad34edb07843db9d6abb7c340bba611c07e/nixos-rebuild.sh
set -e

# Edit your config
$EDITOR ~/nixos-config/home.nix

# cd to your config dir
pushd ~/nixos-config-mac-vm

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes with the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
