{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
