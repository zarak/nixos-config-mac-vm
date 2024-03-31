{pkgs, ...}: let
  colors = import ./wombat.nix;
  # colors = (builtins.fromJSON (builtins.readFile ./themes/custom_jellybeans.json)).colors;
  # colors = (builtins.fromJSON (builtins.readFile ./themes/blood_moon.json)).colors;
  # colors = (builtins.fromJSON (builtins.readFile ./themes/ayu_dark.json)).colors;
  # colors = (builtins.fromJSON (builtins.readFile ./themes/dracula.json)).colors;
in {
  programs.alacritty = {
    enable = true;

    settings = {
      inherit colors;

      scale_with_dpi = true;

      window.opacity = 0.95;

      cursor = {
        style = "block";
        unfocused_hollow = true;
      };

      window = {
        padding = {
          x = 1;
          y = 1;
        };
      };

      dpi = {
        x = 96.0;
        y = 96.0;
      };

      font = {
        size = 10.0;
        # size = 8.0;
      };

      key_bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];

      shell = {program = "${pkgs.fish}/bin/fish";};
    };
  };
}
