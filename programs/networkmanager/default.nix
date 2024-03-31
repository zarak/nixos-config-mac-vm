{pkgs, ...}: {
  services.network-manager-applet.enable = true;

  home.file.".config/networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command  = rofi -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi
    rofi_highlight = True

    [editor]
    gui_if_available = True
  '';
}
