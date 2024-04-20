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
    settings = {
      multi_line = false;
      table_format = "plain";
    };
    extraConfig = builtins.readFile ./myclirc;
  };
}
