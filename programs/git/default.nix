{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
  };
in
{
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userName = "Zarak";
    userEmail = "7254237+zarak@users.noreply.github.com";
  };
}
