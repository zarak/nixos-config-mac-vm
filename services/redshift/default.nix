{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    tray = true;
    latitude = 33.6844;
    longitude = 73.0479;
  };
}
