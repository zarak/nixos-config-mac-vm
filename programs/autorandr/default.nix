{ config, pkgs, ... }:

{
  imports = [
    ./home.nix
    ./work.nix
    ./hooks.nix
  ];

  programs.autorandr = {
    enable = true;
  };
}
