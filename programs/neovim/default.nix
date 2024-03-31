{
  config,
  lib,
  pkgs,
  ...
}: let
  allFiles = builtins.readDir ./lua/custom/plugins;
  luaFiles = builtins.filter (name: lib.hasSuffix ".lua" name) (builtins.attrNames allFiles);
  luaFileMappings =
    builtins.map
    (name: {
      name = ".config/nvim/lua/custom/plugins/${name}";
      value = {source = ./lua/custom/plugins + "/${name}";};
    })
    luaFiles;
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.file =
    lib.listToAttrs luaFileMappings
    // {
      # ".config/nvim/UltiSnips/tex.snippets" = { source = ./UltiSnips/tex.snippets; };
      # ".config/nvim/LuaSnip/all.lua" = { source = ./LuaSnip/all.lua; };
      ".config/nvim/LuaSnip/tex.lua" = {source = ./LuaSnip/tex.lua;};
      # ".config/nvim/UltiSnips/haskell.snippets" = { source = ./UltiSnips/haskell.snippets; };
      ".config/nvim/lua/kickstart/plugins/autoformat.lua" = {source = ./lua/kickstart/plugins/autoformat.lua;};
      ".config/nvim/lua/kickstart/plugins/debug.lua" = {source = ./lua/kickstart/plugins/debug.lua;};
      ".config/nvim/lua/zarak/globals.lua" = {source = ./lua/zarak/globals.lua;};
      ".config/nvim/init.lua" = {source = ./init.lua;};
    };
}
