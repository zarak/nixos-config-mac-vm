{
  description = "Setup a haskell project with cabal and create a repository on
  GitHub";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; };
        scriptName = "setup-haskell-project";
        script = 
          (pkgs.writeScriptBin 
            scriptName 
            (builtins.readFile ./setup-haskell-project.sh)).overrideAttrs(old: {
              buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });

      in rec {
        defaultPackage = packages.script;
        packages.script = pkgs.symlinkJoin {
          name = scriptName;
          paths = [ script pkgs.git pkgs.gh ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = "wrapProgram $out/bin/${scriptName} --prefix PATH : $out/bin";
        };
      }
    );
}
