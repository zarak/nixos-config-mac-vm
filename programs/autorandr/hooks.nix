{
  config,
  pkgs,
  ...
}: {
  programs = {
    autorandr = {
      hooks = {
        postswitch = {
          "restart-xmonad" = ''
            ${pkgs.haskellPackages.xmonad}/bin/xmonad --recompile
            ${pkgs.haskellPackages.xmonad}/bin/xmonad --restart
          '';
          # "set-dpi" = ''
          # ${pkgs.xorg.xrandr}/bin/xrandr --dpi 144
          # '';
        };
      };
    };
  };
}
