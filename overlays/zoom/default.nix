self: super:

{
  zoom-us = super.zoom-us.overrideAttrs (
    old: rec {

      # version = "5.7.28852.0718";
      version = "5.7.28991.0726";
      src = super.fetchurl {
          url = "https://zoom.us/client/${version}/zoom_x86_64.pkg.tar.xz";
          sha256 = "NoB9qxsuGsiwsZ3Y+F3WZpszujPBX/nehtFFI+KPV5E=";
      };
    }
  );
}
