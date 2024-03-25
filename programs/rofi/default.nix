{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme = ./type1_theme.rasi;
    plugins = [ pkgs.rofi-file-browser ];
    extraConfig = {
      modi = "window,run,ssh,file-browser,file-browser-extended";
    };
  };
}
