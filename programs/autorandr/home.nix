{
  config,
  pkgs,
  ...
}: {
  programs.autorandr.profiles = {
    "home" = {
      fingerprint = {
        DP-2 = "00ffffffffffff0030e4e80500000000001c0104a5221378eae085a3544e9b260e5054000000010101010101010101010101010101015e8780a070384d403020350058c21000001b5e8780a07038a0463020350058c21000001b000000fe004c4720446973706c61790a2020000000fe004c503135365746472d5350423200eb";
        HDMI-0 = "00ffffffffffff000469fd22cf7201001418010380301b782a2ac5a4564f9e280f5054b7ef00d1c0814081809500b300714f81c08100023a801871382d40582c4500dc0c1100001e000000ff0045354c4d54463039343932370a000000fd00324b185311000a202020202020000000fc00415355532056533232380a202000c1";
      };

      config = {
        DP-2 = {
          crtc = 0;
          gamma = "1.099:1.0:0.909";
          primary = true;
          enable = true;
          mode = "1920x1080";
          rotate = "normal";
          position = "0x1080";
          rate = "144.00";
        };

        HDMI-0 = {
          crtc = 1;
          gamma = "1.099:1.0:0.909";
          enable = true;
          # enable = false;
          mode = "1920x1080";
          rotate = "normal";
          position = "0x0";
          rate = "60.00";
        };
      };
    };
  };
}
