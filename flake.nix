{
  description = "packer-kvm-images";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      in {
        # for `nix develop`
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            cloud-utils
            packer
            qemu
            terraform
          ];
        };
      }
    );
}
