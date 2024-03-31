{
  config,
  pkgs,
  ...
}: {
  programs.autorandr.profiles = {
    "work" = {
      fingerprint = {
        DP-2 = "00ffffffffffff0030e4e80500000000001c0104a5221378eae085a3544e9b260e5054000000010101010101010101010101010101015e8780a070384d403020350058c21000001b5e8780a07038a0463020350058c21000001b000000fe004c4720446973706c61790a2020000000fe004c503135365746472d5350423200eb";
      };

      config = {
        DP-2 = {
          crtc = 0;
          gamma = "1.099:1.0:0.909";
          primary = true;
          enable = true;
          mode = "1920x1080";
          rotate = "normal";
          position = "0x0";
          rate = "144.00";
        };
      };
    };
  };
}
