{
  config,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
      size = "16x16";
    };

    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = ''0x4-25+25'';
        indicate_hidden = "yes";
        shrink = "no";
        transparency = 10;
        notification_height = 0;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 16;
        frame_width = 2;
        frame_color = "#282a36";
        separator_color = "frame";
        sort = "yes";
        font = "Monospace 10";
        line_height = 0;
        idle_threshold = 120;
        markup = "full";
        format = ''%s %p\n%b'';
        # alignment = "left";
        # vertical_alignment = "center";
        # show_age_threshold = 60;
        # word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        show_indicators = "yes";
        stack_duplicates = true;
        startup_notification = false;
        hide_duplicate_count = false;
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 64;
        sticky_history = "yes";
        history_length = 100;
        # dmenu = "/home/zarak/.nix-profile/bin/dmenu -p dunst";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi";
        browser = "${pkgs.vieb}/bin/vieb";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        verbosity = "mesg";
        corner_radius = 0;
        ignore_dbusclose = false;
        force_xinerama = false;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        # icon_path = "/run/current-system/sw/share/icons/Adwaita/16x16/status/:/run/current-system/sw/share/icons/Adwaita/16x16/devices/:/run/current-system/sw/share/icons/Adwaita/16x16/actions:/run/current-system/sw/share/icons/Adwaita/16x16/apps:/run/current-system/sw/share/icons/Adwaita/16x16/categories/:/run/current-system/sw/share/icons/Adwaita/16x16/emblems/:/run/current-system/sw/share/icons/Adwaita/16x16/emotes/:/run/current-system/sw/share/icons/Adwaita/16x16/legacy:/run/current-system/sw/share/icons/Adwaita/16x16/mimetypes:/run/current-system/sw/share/icons/Adwaita/16x16/places:/run/current-system/sw/share/icons/Adwaita/16x16/ui:~/.nix-profile/share/icons/custom/16x16";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };

      urgency_low = {
        background = "#282a36";
        foreground = "#6272a4";
        timeout = 15;
      };

      urgency_normal = {
        background = "#282a36";
        # foreground = "#bd93f9"
        foreground = "#f8f8f2";
        # foreground = "#6272a4"
        timeout = 15;
      };

      urgency_critical = {
        background = "#ff5555";
        foreground = "#f8f8f2";
        timeout = 0;
      };
    };
  };

  # home.file.".config/dunst/dunstrc".source = ./dunstrc;
}
