self: super: {
  minecraft = super.minecraft.overrideAttrs (
    old: rec {
      version = "2.2.3554";
      src = super.fetchurl {
        # url = "https://launcher.mojang.com/download/linux/x86_64/minecraft-launcher_${version}.tar.gz";
        url = "https://launcher.mojang.com/download/Minecraft.tar.gz";
        sha256 = "1im5xd206xgznbdblwfh9wsldmlndmy9a0821n8bcdjmhfipwyrd";
      };
    }
  );
}
