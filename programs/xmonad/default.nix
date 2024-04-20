{pkgs, isVM, ...}: {
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

  home.file.".xmonad/xmonad.hs".source = 
    (if isVM 
      then ./vm-xmonad.hs
      else ./serval-xmonad.hs);
}
