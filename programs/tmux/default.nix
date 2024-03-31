{
  config,
  pkgs,
  ...
}: let
  tmuxConf = builtins.readFile ./default.conf;
in {
  programs.tmux = {
    enable = true;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";
  };
}
