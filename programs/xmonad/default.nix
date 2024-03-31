{pkgs, ...}: {
  xsession = {
    enable = true;
    initExtra = ''
      nitrogen --restore &
    '';

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
        haskellPackages.raw-strings-qq
        haskellPackages.dbus
      ];
      # config = ./xmonad.hs;
    };
  };

  home.file.".xmonad/xmonad.hs".source = ./xmonad.hs;
}
