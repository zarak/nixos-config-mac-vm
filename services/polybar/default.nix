{ config, pkgs, ... }:

let
  bars   = builtins.readFile ./bars.ini;
  colors = builtins.readFile ./colors.ini;
  mods1  = builtins.readFile ./modules.ini;
  mods2  = builtins.readFile ./user_modules.ini;
in

{
  services.polybar = {
    extraConfig = bars + colors + mods1 + mods2;
    enable = false;
    config = ./config.ini;
    script = ''
      # Terminate already running bar instances
      killall -q polybar

      # Wait until the processes have been shut down
      while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      # Launch the bar
      polybar -q main &
    '';
  };
}
