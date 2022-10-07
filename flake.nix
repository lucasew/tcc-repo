{
  description = "UTFOS";
  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-22.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs = { self, nixpkgs, ... }@args:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    inherit (nixpkgs) lib;
    inherit (lib) concatStringsSep attrValues mapAttrs listToAttrs;
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "devshell";
      shellHook = ''
        PATH="$(pwd)/bin:$PATH"
        NIX_PATH="${concatStringsSep ":" (
          attrValues (
            mapAttrs (k: v: "${k}=${v}") args
          )
        )}:nixpkgs-overlays=$(pwd)/compat/overlay.nix"
      '';
    };
    nixosConfigurations = let
      node = name: lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = {
          inherit self;
        };
        modules = [ "${self}/nodes/${name}/" ];
      };
      nodes = names: listToAttrs (map (name: { inherit name; value = node name; }) names);
    in nodes [
      "demo"
      "solitude"
      "installer"
      "morthal"
      "markarth"
    ];
    inherit pkgs lib; # pra poder usar no nix-repl fácil só com :lf
    overlays = {
      this = import ./overlay.nix self;
    };
    inherit self;
    nixosApplier = pkgs.writeShellScriptBin "switch-to-configuration" ''
      case "$(hostname)" in
         ${builtins.concatStringsSep "\n" ((map (conf: ''
           ${conf.config.networking.hostName})
            ${conf.config.system.build.toplevel}/bin/switch-to-configuration "$@"
           ;;
        '') (builtins.attrValues {
        inherit (self.outputs.nixosConfigurations) solitude installer morthal markarth;
      })))}
          *)
            echo "Este sistema não é conhecido"
          ;;
      esac
    '';
    release = pkgs.stdenv.mkDerivation {
      name = "release";
      dontUnpack = true;
      paths = []
      ++ (map (conf: conf.config.system.build.toplevel) (builtins.attrValues {
        inherit (self.outputs.nixosConfigurations) solitude installer morthal markarth;
      }))
        ;
      installPhase = ''
        for p in "${"$"}{paths[@]}"; do
          echo $p
        done > $out
      '';
    };
  };
}
