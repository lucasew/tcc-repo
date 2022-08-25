{
  description = "UTFOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
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
    nixosConfigurations.${system} = let
      node = name: lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit self;
        };
        modules = [ "${self}/nodes/${name}/" ];
      };
      nodes = names: listToAttrs (map (name: { inherit name; value = node name; }) names);
    in nodes [
      "demo"
      "poc_ubuntu"
    ];
    inherit pkgs lib; # pra poder usar no nix-repl fácil só com :lf
    overlays = {
      this = import ./overlay.nix self;
    };
  };
}
