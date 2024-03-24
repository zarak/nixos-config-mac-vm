{ config, pkgs, lib, ... }:

let
  fzfConfig = ''
    if type rg &> /dev/null
      export FZF_DEFAULT_COMMAND='rg --files'
      export FZF_DEFAULT_OPTS='-m --height 50% --border'
    end
  '';

  customPlugins = pkgs.callPackage ./plugins.nix { };

  fenv = {
    name = "foreign-env";
    src = pkgs.fishPlugins.foreign-env.src;
  };

  fishConfig = ''
    # Disable greeting
    set fish_greeting

    fish_vi_key_bindings

    # doom emacs
    # set PATH $PATH:~/.emacs.d/bin
    fish_add_path ~/.emacs.d/bin

    # set fish_ambiguous_width 1
    # set fish_emoji_width 1

    set fish_right_prompt

    set -Ux WINIT_X11_SCALE_FACTOR 1.0833333333333333
  '' + fzfConfig;
in
{
  programs.fish = {
    enable = true;
    plugins = [ fenv ];
    interactiveShellInit = ''
      starship init fish | source
      direnv hook fish | source
    '';
    shellAliases = {
      hms = "home-manager switch";
      cabit = "cabal init --non-interactive --license=MIT --author=Zarak --libandexe --tests --language=GHC2021 --no-comments";
      ne = "nix-instantiate --eval";
      cat = "bat";
      du = "ncdu --color dark -rr -x";
      ping = "prettyping";

      # threadscope = "/home/zarak/.cabal/bin/threadscope";

      update = "sudo nixos-rebuild switch";

      # Eza ls replacement
      ls = "${pkgs.eza}/bin/eza --group-directories-first";
      l = "${pkgs.eza}/bin/eza -lbF --git --group-directories-first --icons";
      ll = "${pkgs.eza}/bin/eza -lbF --git --group-directories-first --icons";
      llm =
        "${pkgs.eza}/bin/eza -lbGd --git --sort=modified --group-directories-first --icons";
      la =
        "${pkgs.eza}/bin/eza -lbhHigmuSa --time-style=long-iso --git --color-scale --group-directories-first --icons";
      lx =
        "${pkgs.eza}/bin/eza -lbhHigmuSa@ --time-style=long-iso --git --color-scale --group-directories-first --icons";
      lt =
        "${pkgs.eza}/bin/eza --tree --level=2 --group-directories-first --icons";

      # Git
      g = "git";
      ga = "git add";
      gcam = "git commit -a -m";
      gd = "git diff";
      glog = "git log --oneline --decorate --graph";
      gp = "git push";
      gst = "git status";

      # Idris
      idris2 = "rlwrap idris2";
    };

    shellInit = fishConfig;

    functions =
      {
        latest_generation = {
          body = ''
            command notify-send (home-manager generations | awk 'NR==1{print $1, $2 "\n" "Generation <b>" $5 "</b>"}')
          '';
        };
        fish_title = {
          body = ''
            set -q argv[1]; or set argv fish
            echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
          '';
        };

        prev = {
          body = ''
            set line (echo $history[1])
            pet new $line
          '';
        };

        # set_newline = {
        # body = ''
        # set fp /home/zarak/.config/nixpkgs/programs/starship/starship.toml
        # if test $argv = true
        # command sed -i 's/disabled = true/disabled = false/g' $fp
        # else
        # command sed -i 's/disabled = false/disabled = true/g' $fp
        # end
        # command home-manager switch
        # '';
        # };
      };
  };
}
