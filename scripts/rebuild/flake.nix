{
  description = "Automate common tasks when updating the system config";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        scriptName = "rebuild";
        script =
          (pkgs.writeScriptBin
            scriptName
            (builtins.readFile ./nixos-rebuild.sh))
          .overrideAttrs (old: {
            buildCommand = "${old.buildCommand}\n patchShebangs $out";
          });
      in rec {
        defaultPackage = packages.script;
        packages.script = pkgs.symlinkJoin {
          name = scriptName;
          paths = [script] ++ (with pkgs; [git alejandra libnotify]);
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/${scriptName} --prefix PATH : $out/bin";
        };
      }
    );
}
