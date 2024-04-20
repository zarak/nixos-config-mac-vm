{ config, lib, pkgs, ... }:

let
  cfg = config.programs.mycli;
  formatLine = n: v:
    let
      formatValue = v:
        if builtins.isBool v then
          (if v then "True" else "False")
        else
          toString v;
    in "${n} = ${formatValue v}";
in {
  meta.maintainers = [ lib.maintainers.zarak ];

  options.programs.mycli = {
    enable = lib.mkEnableOption "mycli";

    settings = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ bool str ]);
      default = { };
      description = ''
        See 
        https://www.mycli.net/config 
        for options.
      '';
      example = lib.literalExpression ''
        {
          smart_completion = true;
          multi_line = false;
          table_format = "ascii";
        }
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra lines added to {file}`myclirc` file.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.mycli ];

    xdg.configFile."mycli/myclirc".text = lib.concatStringsSep "\n" ([ ]
      ++ lib.mapAttrsToList formatLine cfg.settings
      ++ lib.optional (cfg.extraConfig != "") cfg.extraConfig);
  };
}
