{ config, pkgs, inputs, ... }:

let
  basePkgs = with pkgs; [
    inputs.setup-haskell-project.defaultPackage."${pkgs.system}"
    (agda.withPackages (p: [ p.standard-library ])) # dependent types
    # agda-pkg # agda package management
    # alass # subtitle synchronization
    # anki                             # spaced repetition software
    # anki-bin # spaced repetition software
    # appimage-run # run appimage apps
    # aseprite # pixel art
    # (aseprite.override { unfree = true; })
    # audacity
    arandr # simple GUI for xrandr
    aria2 # lightweight download utility
    awscli # aws command line interface
    nodePackages.bash-language-server
    bear
    # burpsuite                        # web application security scanner
    # bfg-repo-cleaner                 # Utility to mage files in git cache
    # blender # 3D modeling software
    cachix # nix binary caching
    # cargo # rust package manager
    # cc65 # c-compiler for 6502 processors
    ccls # c/c++ language server
    clang # C/C++ compiler
    clang-tools
    # clojure # lisp dialect on jvm
    # clojure-lsp # clojure language server
    cmake # cross-platform make system
    coq # proof assistant

    # cudnn_8_3_cudatoolkit_11_5
    # dafny # software verification
    # difftastic # diff checker
    dig
    dmenu # application launcher
    # dropbox # Cloud file storage
    dunst # lightweight notification daemon
    elan # manage installatinos of lean theorem prover
    # element-desktop # matrix client
    emacs # extensible text editor
    eza # a modern replacement for ls
    exercism # programming puzzles
    # fceux # nintendo emulator and debugger
    fd # find entries in the filesystem
    ffmpeg
    fh # flakehub
    # flameshot # screenshots with annotations
    # gcc                              # C compiler
    gdb # GNU project debugger
    gh # github cli
    # ghidra # reverse engineering tools
    gibo
    # gimp # gnu image manipulation program
    # gist # upload code to github as a gist
    gnumake # generate executables from source
    gparted
    htop
    httpie # command line HTTP client
    http-prompt # interactive command-line HTTP client
    # hugo # static site generator
    # hy                               # lisp dialect embedded in python
    # idris                            # type driven development
    imagemagick # convert digital images
    # inkscape # vector graphics
    ispell # Spellcheck for emacs
    # jdk                              # java development kit
    # jetbrains.idea-community # IDE for Java
    # jetbrains.jdk # java development kit - fork for jetbrains
    # kakoune                          # vim inspired text editor
    # kdenlive                         # video editing software
    killall # kill processes by name
    # lean3                            # lean theorem prover
    # leiningen # build automation for clojure
    litecli # improved sqlite cli
    lsof # list open files
    # llvmPackages_rocm.clang-tools-extra
    lua-language-server # lua language server
    luaPackages.luarocks # package manager for lua
    manix # search tool for nix module options
    # mathlibtools # math library for lean
    # minecraft
    # mplayer # media player
    # mpv # command line media player
    # musescore # music composition and notation
    ncdu # improved du
    neofetch # system information
    netlify-cli # CLI for netlify
    networkmanager # cli for network management
    networkmanager_dmenu # manage with dmenu
    networkmanagerapplet # gui for network management
    nitrogen
    nix-prefetch-git # get sha256 hash of git repo
    nixd # nix language server
    # nixFlakes                        # upcoming feature of nix
    nix-tree
    nmap # network scanner
    # obsidian                         # knowledge base of markdown files
    # ocaml                            # functional programming language
    p7zip # unzip 7z files
    pciutils # utilities like lspci
    pet # snippet manager
    perl536Packages.LatexIndent # format latex code
    pgcli # postgres cli with auto-completion 
    prettyping # improved ping
    pscid # purescript filewatcher (like ghcid)
    # qalculate-gtk # desktop calculator
    # qbittorrent # bittorrent client
    racket # a programmable programming language
    # reaper                           # Reaper DAW
    redis # command line for redis
    ripgrep # line-oriented search tool
    rofi-file-browser # open files using rofi
    shotgun # minimal screenshot utility
    # signal-desktop                   # secure messaging
    shellcheck
    sioyek # pdf reader
    speedtest-cli # test internet bandwidth
    sqlite
    # termonad # terminal emulator
    tor
    torsocks
    tmate # instant terminal sharing
    tree # display files in tree view
    unrar # unzip rar files
    # upwork # time tracking tool for freelance work
    unzip # decompress zip files
    vieb # vim inspired electron browser
    wezterm # gpu based terminal
    # wireshark # network protocol analyzer
    xclip # copy to clipboard
    xfce.xfce4-taskmanager # easy to use GUI task manager
    xorg.xdpyinfo # get screen resolution
    xxd # convert binary to hex
    youtube-dl # YouTube video downloader
    yq # convert from YAML to json
  ];

  gnomePkgs = with pkgs.gnome3; [
    adwaita-icon-theme
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    cabal-install
    cabal2nix
    fourmolu
    hakyll
    hoogle
    haskell-language-server
    ghc
    ghcid
    # profiteur # treemap visualizer for GHC prof files
    # stack
    # threadscope # parallel programming in haskell
  ];

  ocamlPkgs = with pkgs.ocamlPackages; [
    # utop
  ];

  fishPkgs = with pkgs.fishPlugins; [
    pkgs.fishPlugins.done
    pkgs.fishPlugins.fzf-fish
  ];

  linuxPkgs = with pkgs.linuxPackages; [
    bcc
  ];

  texPkgs = with pkgs.texlive; [
    combined.scheme-full
  ];
in

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.nushell.enable = true;
  # programs.nix-index = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };

  # nixpkgs.overlays = [
  #   # (import ./overlays/zoom)
  #   (import ./overlays/discord)
  #   # (import ./overlays/aseprite)
  #   # (import ./overlays/minecraft)
  # ];

  # nixpkgs.config = {
  #   allowUnfree = true;
  # };

  # nixpkgs.config.permittedInsecurePackages = [
  #   "python-2.7.18.6"
  # ];


  imports = [
    # ./programs/alacritty/default.nix
    ./programs/fish/default.nix
    ./programs/git/default.nix
    ./programs/neovim/default.nix
    ./programs/networkmanager/default.nix
    ./programs/rofi/default.nix
    ./programs/starship/default.nix
    ./programs/tmux/default.nix
    ./programs/xmonad/default.nix
    # ./programs/autorandr/default.nix
    ./programs/zathura/default.nix
    ./programs/wezterm/default.nix
    # ./programs/helix/default.nix
    ./services/dunst/default.nix
    # ./services/picom/default.nix
    # ./services/polybar/default.nix
    # ./services/redshift/default.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "zarak";
  home.homeDirectory = "/home/zarak";

  home.packages =
    basePkgs
    ++ gnomePkgs
    ++ haskellPkgs
    ++ fishPkgs
    ++ linuxPkgs
    ++ texPkgs
    ++ ocamlPkgs;

  xsession.numlock.enable = true;

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  programs = {
    bat.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    jq.enable = true;

    ssh = {
      enable = true;
      compression = true;
      matchBlocks."z0k" = {
        host = "z0k";
        hostname = "gitlab.com";
        identityFile = "~/.ssh/id_ed25519new";
        identitiesOnly = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  xresources.properties = {
    # Set this below with pointerCursor
    # "Xcursor.size" = 128;
    "Xft.dpi" = 192;
  };

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };

  # xdg.configFile = {
  # "nvim/coc-settings.json".text = cocSettings;
  # };

  # Raw config files
  # home.file.".config/alacritty/alacritty.yml".source=  ./alacritty/alacritty.yml;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
