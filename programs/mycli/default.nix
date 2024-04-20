{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/mycli.nix
  ];

  programs.mycli = {
    enable = true;
    settings = {
      smart_completion = true;
      multi_line = true;
      destructive_warning = true;
      log_file = "~/.mycli.log";
      log_level = "INFO";
      audit_log = "~/.mycli-audit.log";
      timing = true;
      table_format = "ascii";
      syntax_style = "default";
      key_bindings = "vi";
      wider_completion_menu = false;
      prompt = ''
        '\t \u@\h:\d> '
      '';
      less_chatty = false;
      login_path_as_host = false;
      auto_vertical_output = false;
      keyword_casing = "auto";
      enable_pager = true;
      pager = ''
      'vim -c "set nowrap"'
      '';
    };
    extraConfig = builtins.readFile ./myclirc;
  };
}
