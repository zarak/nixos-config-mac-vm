{pkgs, ...}: let
  config = builtins.readFile ./wezterm.lua;
in {
  programs.wezterm = {
    enable = true;

    extraConfig = config;
  };
}
