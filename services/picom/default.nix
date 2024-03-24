{
  services.picom = {
    enable = false;
    activeOpacity = "1.0";
    inactiveOpacity = "0.92";
    fade = true;
    fadeDelta = 5;
    opacityRules = [
      "100:name *= 'xlock'"
      "100:name *= 'Chrome'"
      "100:name *= 'rofi'"
      "100:name *= 'qutebrowser'"
      "100:name *= 'Firefox'"
      "100:name *= 'Anki'"
      "100:name *= 'mpv'"
      "100:name *= 'polybar'"
      "100:name *= 'Emacs'"
    ];
    shadow = true;
    shadowOpacity = "0.75";
  };
}
