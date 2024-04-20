{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/mycli.nix
  ];

  programs.mycli = {
    enable = true;
    extraConfig = builtins.readFile ./myclirc;
  };
}
